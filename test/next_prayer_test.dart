import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_poject_final/features/home/presentation/manager/home_cubit.dart';
import 'package:flutter_poject_final/features/prayers/data/models/prayer_times_model.dart';

void main() {
  const timings = PrayerTimingsModel(
    date: '2026-09-11',
    hijriDate: '28 Rabi\' al-Awwal 1448',
    latitude: 15.3694,
    longitude: 44.191,
    calculationMethod: 'MuslimWorldLeague',
    fajr: '04:30',
    sunrise: '05:45',
    dhuhr: '12:15',
    asr: '15:30',
    maghrib: '18:10',
    isha: '19:40',
  );

  group('Next Prayer Calculation Tests (Section 28 Requirements)', () {
    test('1. Current < Fajr -> Next = Fajr', () {
      final now = DateTime(2026, 9, 11, 3, 0); // 03:00 AM
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'fajr');
      expect(next.prayerTime, '04:30');
      expect(next.isTomorrow, false);
      expect(next.remaining.inMinutes, 90); // 1h 30m
      expect(next.formattedCountdown, '01:30:00');
    });

    test('2. Current between Fajr and Dhuhr -> Next = Dhuhr (skips Sunrise)', () {
      // At 05:00 (between Fajr 04:30 and Sunrise 05:45)
      final now1 = DateTime(2026, 9, 11, 5, 0);
      final next1 = HomeCubit.calculateNextPrayer(timings, now1);
      expect(next1.prayerKey, 'dhuhr');
      expect(next1.prayerTime, '12:15');
      expect(next1.isTomorrow, false);

      // At 08:00 (after Sunrise 05:45 and before Dhuhr 12:15)
      final now2 = DateTime(2026, 9, 11, 8, 0);
      final next2 = HomeCubit.calculateNextPrayer(timings, now2);
      expect(next2.prayerKey, 'dhuhr');
      expect(next2.prayerTime, '12:15');
      expect(next2.isTomorrow, false);
      expect(next2.formattedCountdown, '04:15:00');
    });

    test('3. Current between Dhuhr and Asr -> Next = Asr', () {
      final now = DateTime(2026, 9, 11, 13, 0); // 13:00 PM
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'asr');
      expect(next.prayerTime, '15:30');
      expect(next.isTomorrow, false);
      expect(next.remaining.inMinutes, 150); // 2h 30m
      expect(next.formattedCountdown, '02:30:00');
    });

    test('4. Current between Asr and Maghrib -> Next = Maghrib', () {
      final now = DateTime(2026, 9, 11, 16, 0); // 16:00 PM
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'maghrib');
      expect(next.prayerTime, '18:10');
      expect(next.isTomorrow, false);
      expect(next.remaining.inMinutes, 130); // 2h 10m
      expect(next.formattedCountdown, '02:10:00');
    });

    test('5. Current between Maghrib and Isha -> Next = Isha', () {
      final now = DateTime(2026, 9, 11, 18, 30); // 18:30 PM
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'isha');
      expect(next.prayerTime, '19:40');
      expect(next.isTomorrow, false);
      expect(next.remaining.inMinutes, 70); // 1h 10m
      expect(next.formattedCountdown, '01:10:00');
    });

    test('6. Current after Isha -> Next = Tomorrow Fajr with positive countdown', () {
      final now = DateTime(2026, 9, 11, 21, 0); // 21:00 PM
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'fajr');
      expect(next.prayerTime, '04:30');
      expect(next.isTomorrow, true);
      // From 21:00 to 04:30 next day = 7 hours 30 minutes
      expect(next.remaining.inMinutes, 450);
      expect(next.formattedCountdown, '07:30:00');
      expect(next.remaining.isNegative, false);
    });

    test('7. Countdown formatting handles single digits and zero correctly', () {
      final now = DateTime(2026, 9, 11, 12, 14, 15);
      final next = HomeCubit.calculateNextPrayer(timings, now);

      expect(next.prayerKey, 'dhuhr');
      expect(next.remaining.inSeconds, 45);
      expect(next.formattedCountdown, '00:00:45');
    });
  });
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../prayers/data/models/prayer_times_model.dart';
import '../../../prayers/data/repos/prayers_repo.dart';
import '../../data/models/next_prayer_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PrayerRepo prayerRepo;
  Timer? _countdownTimer;
  PrayerTimingsModel? _currentTimings;

  HomeCubit({
    required this.prayerRepo,
  }) : super(HomeInitial());

  Future<void> getHomeData({
    double latitude = 15.3694,
    double longitude = 44.191,
  }) async {
    emit(HomeLoading());

    final result = await prayerRepo.getPrayerTimings(
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) => emit(
        HomeFailure(
          errorMessage: failure.message,
        ),
      ),
      (prayerTimings) {
        _currentTimings = prayerTimings;
        _updateNextPrayer();
        _startTimer();
      },
    );
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _tick();
      },
    );
  }

  void _tick() {
    if (_currentTimings == null) return;
    _updateNextPrayer();
  }

  void _updateNextPrayer() {
    final timings = _currentTimings;
    if (timings == null) return;

    final now = DateTime.now();
    final nextPrayer = calculateNextPrayer(timings, now);

    emit(
      HomeLoaded(
        prayerTimings: timings,
        nextPrayer: nextPrayer,
      ),
    );
  }

  static DateTime? parseTimeToDateTime(String timeStr, DateTime referenceDate) {
    try {
      final parts = timeStr.trim().split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0].trim());
        final minute = int.parse(parts[1].trim().split(' ')[0]);
        return DateTime(
          referenceDate.year,
          referenceDate.month,
          referenceDate.day,
          hour,
          minute,
        );
      }
    } catch (_) {}
    return null;
  }

  static NextPrayerModel calculateNextPrayer(
    PrayerTimingsModel timings,
    DateTime now,
  ) {
    final fajrTime = parseTimeToDateTime(timings.fajr, now);
    final dhuhrTime = parseTimeToDateTime(timings.dhuhr, now);
    final asrTime = parseTimeToDateTime(timings.asr, now);
    final maghribTime = parseTimeToDateTime(timings.maghrib, now);
    final ishaTime = parseTimeToDateTime(timings.isha, now);

    if (fajrTime != null && now.isBefore(fajrTime)) {
      return NextPrayerModel(
        prayerKey: 'fajr',
        prayerTime: timings.fajr,
        remaining: fajrTime.difference(now),
        isTomorrow: false,
      );
    } else if (dhuhrTime != null && now.isBefore(dhuhrTime)) {
      // Sunrise is skipped as required by specifications
      return NextPrayerModel(
        prayerKey: 'dhuhr',
        prayerTime: timings.dhuhr,
        remaining: dhuhrTime.difference(now),
        isTomorrow: false,
      );
    } else if (asrTime != null && now.isBefore(asrTime)) {
      return NextPrayerModel(
        prayerKey: 'asr',
        prayerTime: timings.asr,
        remaining: asrTime.difference(now),
        isTomorrow: false,
      );
    } else if (maghribTime != null && now.isBefore(maghribTime)) {
      return NextPrayerModel(
        prayerKey: 'maghrib',
        prayerTime: timings.maghrib,
        remaining: maghribTime.difference(now),
        isTomorrow: false,
      );
    } else if (ishaTime != null && now.isBefore(ishaTime)) {
      return NextPrayerModel(
        prayerKey: 'isha',
        prayerTime: timings.isha,
        remaining: ishaTime.difference(now),
        isTomorrow: false,
      );
    } else {
      // After Isha: Next prayer is tomorrow's Fajr
      final tomorrow = now.add(const Duration(days: 1));
      final tomorrowFajr = parseTimeToDateTime(timings.fajr, tomorrow);
      final remaining = tomorrowFajr != null
          ? tomorrowFajr.difference(now)
          : Duration.zero;

      return NextPrayerModel(
        prayerKey: 'fajr',
        prayerTime: timings.fajr,
        remaining: remaining.isNegative ? Duration.zero : remaining,
        isTomorrow: true,
      );
    }
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}

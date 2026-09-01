import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../models/prayer_tracker_model.dart';
import 'prayer_tracker_repo.dart';

class PrayerTrackerRepoImpl implements PrayerTrackerRepo {
  final SharedPreferences sharedPreferences;

  PrayerTrackerRepoImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, PrayerTrackerModel>> getPrayerTracker(
    String date,
  ) async {
    try {
      final data = sharedPreferences.getString(
        'prayer_tracker_$date',
      );

      if (data == null) {
        return right(
          PrayerTrackerModel(
            date: date,
            fajr: false,
            dhuhr: false,
            asr: false,
            maghrib: false,
            isha: false,
          ),
        );
      }

      final json = jsonDecode(data) as Map<String, dynamic>;

      return right(
        PrayerTrackerModel.fromJson(json),
      );
    } catch (e) {
      return left(
        CacheFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, PrayerTrackerModel>> updatePrayer(
    String date,
    String prayer,
    bool isPrayed,
  ) async {
    try {
      final result = await getPrayerTracker(date);

      return await result.fold(
        (failure) async => left(failure),
        (tracker) async {
          final updatedTracker = tracker.copyWith(
            fajr: prayer == 'fajr' ? isPrayed : null,
            dhuhr: prayer == 'dhuhr' ? isPrayed : null,
            asr: prayer == 'asr' ? isPrayed : null,
            maghrib: prayer == 'maghrib' ? isPrayed : null,
            isha: prayer == 'isha' ? isPrayed : null,
          );

          await sharedPreferences.setString(
            'prayer_tracker_$date',
            jsonEncode(updatedTracker.toJson()),
          );

          return right(updatedTracker);
        },
      );
    } catch (e) {
      return left(
        CacheFailure(e.toString()),
      );
    }
  }
}

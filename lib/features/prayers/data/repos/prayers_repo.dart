import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/prayer_times_model.dart';

abstract class PrayerRepo {
  Future<Either<Failure, PrayerTimingsModel>> getPrayerTimings({
    required double latitude,
    required double longitude,
    String? date,
  });
}

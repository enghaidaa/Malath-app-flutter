import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/prayer_tracker_model.dart';

abstract class PrayerTrackerRepo {
  Future<Either<Failure, PrayerTrackerModel>> getPrayerTracker(
    String date,
  );

  Future<Either<Failure, PrayerTrackerModel>> updatePrayer(
    String date,
    String prayer,
    bool isPrayed,
  );
}

import 'package:dartz/dartz.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/api_service.dart';
import '../models/prayer_times_model.dart';
import 'prayers_repo.dart';

class PrayerRepoImpl implements PrayerRepo {
  final ApiService apiService;

  PrayerRepoImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, PrayerTimingsModel>> getPrayerTimings({
    required double latitude,
    required double longitude,
    String? date,
  }) async {
    try {
      final response = await apiService.get(
        EndPoints.prayerTimings,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          if (date != null) 'date': date,
        },
      );

      final prayerTimings = PrayerTimingsModel.fromJson(
        response['data'] as Map<String, dynamic>,
      );

      return right(prayerTimings);
    } catch (e) {
      return left(
        ServerFailure(e.toString()),
      );
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/api_service.dart';
import '../models/azkar_model.dart';
import 'azkar_repo.dart';

class AzkarRepoImpl implements AzkarRepo {
  final ApiService apiService;

  AzkarRepoImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<AzkarModel>>> getAzkar() async {
    try {
      final response = await apiService.get(
        EndPoints.azkar,
      );

      final azkar = (response['data']['azkar'] as List)
          .map(
            (item) => AzkarModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();

      return right(azkar);
    } catch (e) {
      return left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, AzkarModel>> getAzkarByCategory(
    String category,
  ) async {
    try {
      final response = await apiService.get(
        EndPoints.azkarByCategory(category),
      );

      final azkar = AzkarModel.fromJson(
        response['data']['azkar'] as Map<String, dynamic>,
      );

      return right(azkar);
    } catch (e) {
      return left(
        ServerFailure(e.toString()),
      );
    }
  }
}

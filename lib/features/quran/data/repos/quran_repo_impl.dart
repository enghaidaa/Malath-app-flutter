import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/api/end_points.dart';
import '../models/surah_model.dart';
import 'quran_repo.dart';

class QuranRepoImpl implements QuranRepo {
  final ApiService apiService;

  QuranRepoImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<SurahModel>>> getSurahs() async {
    try {
      final response = await apiService.get(
        EndPoints.quranSurahs,
      );

      final surahs = (response['data']['surahs'] as List)
          .map(
            (surah) => SurahModel.fromJson(
              surah as Map<String, dynamic>,
            ),
          )
          .toList();

      return right(surahs);
    } catch (e) {
      return left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, SurahModel>> getSurahById(int id) async {
    try {
      final response = await apiService.get(
        EndPoints.quranSurahById(id),
      );

      final surah = SurahModel.fromJson(
        response['data']['surah'] as Map<String, dynamic>,
      );

      return right(surah);
    } catch (e) {
      return left(
        ServerFailure(e.toString()),
      );
    }
  }
}

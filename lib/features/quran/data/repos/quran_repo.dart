import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/surah_model.dart';

abstract class QuranRepo {
  Future<Either<Failure, List<SurahModel>>> getSurahs();

  Future<Either<Failure, SurahModel>> getSurahById(int id);
}

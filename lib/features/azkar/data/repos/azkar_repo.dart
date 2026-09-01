import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/azkar_model.dart';

abstract class AzkarRepo {
  Future<Either<Failure, List<AzkarModel>>> getAzkar();

  Future<Either<Failure, AzkarModel>> getAzkarByCategory(
    String category,
  );
}

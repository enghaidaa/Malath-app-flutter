import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/my_azkar_model.dart';

abstract class MyAzkarRepo {
  Future<Either<Failure, List<MyAzkarModel>>> getMyAzkar();

  Future<Either<Failure, Unit>> addAzkar(
    MyAzkarModel azkar,
  );

  Future<Either<Failure, Unit>> deleteAzkar(
    int id,
  );
}

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> loginWithGoogle();

  Future<Either<Failure, void>> logout();
}

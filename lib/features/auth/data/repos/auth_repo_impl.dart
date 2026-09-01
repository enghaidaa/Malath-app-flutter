import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../models/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImpl({
    required this.firebaseAuthService,
  });

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuthService.login(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        return left(
          const FirebaseAuthFailure('Login failed'),
        );
      }

      final userModel = UserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? email,
        photoUrl: user.photoURL,
      );

      return right(userModel);
    } on AuthException catch (error) {
      return left(
        FirebaseAuthFailure(error.message),
      );
    } catch (error) {
      return left(
        FirebaseAuthFailure('Login failed: $error'),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuthService.register(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        return left(
          const FirebaseAuthFailure(
            'Registration failed: user is null',
          ),
        );
      }

      await user.updateDisplayName(name);

      final userModel = UserModel(
        uid: user.uid,
        name: name,
        email: user.email ?? email,
        photoUrl: user.photoURL,
      );

      return right(userModel);
    } on AuthException catch (error) {
      return left(
        FirebaseAuthFailure(error.message),
      );
    } catch (error) {
      return left(
        FirebaseAuthFailure(
          'Registration failed: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final userCredential = await firebaseAuthService.loginWithGoogle();

      final user = userCredential.user;

      if (user == null) {
        return left(
          const FirebaseAuthFailure('Google Sign-In failed'),
        );
      }

      final userModel = UserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL,
      );

      return right(userModel);
    } on AuthException catch (error) {
      return left(
        FirebaseAuthFailure(error.message),
      );
    } catch (error) {
      return left(
        FirebaseAuthFailure(
          'Google Sign-In failed: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebaseAuthService.logout();

      return right(null);
    } on AuthException catch (error) {
      return left(
        FirebaseAuthFailure(error.message),
      );
    } catch (error) {
      return left(
        FirebaseAuthFailure(
          'Logout failed: $error',
        ),
      );
    }
  }
}

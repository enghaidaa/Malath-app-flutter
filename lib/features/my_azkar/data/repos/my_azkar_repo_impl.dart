import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../../../../core/services/firebase_firestore_service.dart';
import '../models/my_azkar_model.dart';
import 'my_azkar_repo.dart';

class MyAzkarRepoImpl implements MyAzkarRepo {
  final FirebaseFirestoreService firestoreService;
  final FirebaseAuthService authService;

  MyAzkarRepoImpl({
    required this.firestoreService,
    required this.authService,
  });

  String get collectionPath {
    final user = authService.getCurrentUser();

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return 'users/${user.uid}/myAzkar';
  }

  @override
  Future<Either<Failure, List<MyAzkarModel>>> getMyAzkar() async {
    try {
      final response = await firestoreService.getCollectionData(
        collectionPath: collectionPath,
      );

      final azkar = response
          .map(
            (azkar) => MyAzkarModel.fromJson(azkar),
          )
          .toList();

      return right(azkar);
    } catch (e) {
      return left(
        FirebaseFirestoreFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addAzkar(
    MyAzkarModel azkar,
  ) async {
    try {
      await firestoreService.addData(
        collectionPath: collectionPath,
        documentId: azkar.id.toString(),
        data: azkar.toJson(),
      );

      return right(unit);
    } catch (e) {
      return left(
        FirebaseFirestoreFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAzkar(
    int id,
  ) async {
    try {
      await firestoreService.deleteData(
        collectionPath: collectionPath,
        documentId: id.toString(),
      );

      return right(unit);
    } catch (e) {
      return left(
        FirebaseFirestoreFailure(e.toString()),
      );
    }
  }
}

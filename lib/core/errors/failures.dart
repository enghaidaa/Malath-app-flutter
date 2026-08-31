abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(super.message);
}

class FirebaseFirestoreFailure extends Failure {
  const FirebaseFirestoreFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

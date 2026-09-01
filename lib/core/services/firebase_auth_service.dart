import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../errors/exceptions.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      print('AUTH SERVICE 1: Creating user...');

      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('AUTH SERVICE 2: User created');
      print('AUTH SERVICE 3: UID = ${result.user?.uid}');
      print('AUTH SERVICE 4: Email = ${result.user?.email}');

      return result;
    } on FirebaseAuthException catch (error) {
      print('AUTH SERVICE FIREBASE ERROR');
      print('CODE: ${error.code}');
      print('MESSAGE: ${error.message}');
      print('DETAILS: ${error.stackTrace}');

      throw AuthException(
        '${error.code}: ${error.message ?? 'Registration failed'}',
      );
    } catch (error, stackTrace) {
      print('AUTH SERVICE UNKNOWN ERROR');
      print('ERROR: $error');
      print('STACK: $stackTrace');

      throw AuthException(
        'Registration failed: $error',
      );
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.message ?? 'Login failed');
    } catch (_) {
      throw AuthException('Login failed');
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException('Google Sign-In was cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw AuthException(
        error.message ?? 'Google Sign-In failed',
      );
    } on AuthException {
      rethrow;
    } catch (error) {
      throw AuthException(
        'Google Sign-In failed: $error',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.message ?? 'Logout failed');
    } catch (_) {
      throw AuthException('Logout failed');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/error.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    } catch (e) {
      print('General Error: $e');
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<UserCredential?> signUpWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    } catch (e) {
      print('General Error: $e');
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Current User
  User? get currentUser => _auth.currentUser;
}

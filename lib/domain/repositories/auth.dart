import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/error.dart';
import 'package:todo_app/features/data/models/user.dart';
import 'package:todo_app/utils/collections.dart';

class Auth {
  final CloudStorageCollections cloudcollection = CloudStorageCollections();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<NetworkResponse> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        return NetworkResponse(isSuccess: true);
      }
      return NetworkResponse(isSuccess: false, error: 'Failed to login');
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    } catch (e) {
      print('General Error: $e');
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<NetworkResponse> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      log('message : $user');
      if (user != null) {
        final userdata = Userdata(
          createdAt: Timestamp.now(),
          displayName: name,
          email: user.email,
          emailVerified: user.emailVerified,
          isAnonymous: user.isAnonymous,
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL,
          refreshToken: user.refreshToken,
          password: password,
          status: 1,
          tenantId: user.tenantId,
          uid: user.uid,
        );
        final uploaderResult = await uploaduser(user.uid, userdata.toJson());

        if (uploaderResult.isSuccess) {
          return NetworkResponse(isSuccess: true);
        } else {
          return NetworkResponse(isSuccess: false, error: uploaderResult.error);
        }
      }
      return NetworkResponse(isSuccess: false);
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

  Future<NetworkResponse> uploaduser(String userid, Map<String, dynamic> data) async {
    log('uploadi');
    try {
      await cloudcollection.usercollection.doc(userid).set(data);
      return NetworkResponse(isSuccess: true);
    } on FirebaseException catch (e) {
      log('firrr eerroror : ${e.code}');
      return NetworkResponse(isSuccess: false, error: 'Firebase Error : ${e.code}');
    } catch (e) {
      return NetworkResponse(isSuccess: false, error: 'Error : $e');
    }
  }
}

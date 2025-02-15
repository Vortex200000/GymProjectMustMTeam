import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';

abstract class AuthRemoteData {
  Future<UserCredential> signInEmailAndPassword(AuthParameters params);
  Future<UserCredential> signUpWithEmailAndPassword(AuthParameters params);
  Future<User?> checkIfUserLoggedIn();
  Future<void> signOut();

  Future<void> resetPassword(String email);
  // Future<String> getProviderInfo();
}

class AuthFireBase extends AuthRemoteData {
  // final FirebaseAuth
  AuthFireBase(
    this._auth,
  );
  final FirebaseAuth _auth;
  // final FirebaseFirestore _fireStore;
  // final FireBaseService _fireStoreService;

  @override
  Future<UserCredential> signInEmailAndPassword(AuthParameters params) async {
    return await _auth.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      AuthParameters params) async {
    return await _auth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);
  }

  @override
  Future<User?> checkIfUserLoggedIn() async {
    User? user = await _auth.currentUser;
    log(' ============> ${_auth.currentUser?.uid.toString()}');
    if (user != null) return user;
    return null;
  }

  @override
  Future<void> signOut() async {
    // String userProvider = await getProviderInfo();
    // if (userProvider == 'google') {
    //   GoogleSignIn().signOut();
    // }
    await _auth.signOut();
  }

  // Map<String, dynamic> saveProfMap(String id, bool state) => {
  //   AccountKeys.id : id ,
  //   AccountKeys.isSaved : state
  // };

  @override
  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}

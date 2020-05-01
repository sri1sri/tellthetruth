import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tellthetruth/database_model/user_details.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

import 'database.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanges;

  Future<User> currentUser();

  Future<User> signInWithEmail(String email, String password);

  Future<User> registerWithEmail(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  String verificationId;
  String phoneNumberWithCode;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanges {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final userDetails = UserDetails(deviceToken: '$USER_DEVICE_TOKEN');

    DBreference.updateUserDetails(userDetails, authResult.user.uid.toString());
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> registerWithEmail(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    USER_ID = authResult.user.uid.toString();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {

    await _firebaseAuth.signOut();
  }
}

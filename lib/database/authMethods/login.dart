import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginUser {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Future<User?> loginUser(
      BuildContext context, String? email, String? password) async {
    try {
      final UserCredential? userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      return userCredential!.user;
    } on Exception catch (e) {
      print('Error in User creation: $e');
      return null;
    }
  }
  static Future<void>signOut()async => await _firebaseAuth.signOut();
}

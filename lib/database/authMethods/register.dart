import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterUser {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///New User Registration OR Account Creation
  static Future<User?> registerNewUser(
      BuildContext context, String? email, String? password) async {
    try {
      final UserCredential? userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential!.user;
    } on Exception catch (e) {
      print('Error in User creation: $e');
      return null;
    }
  }
}

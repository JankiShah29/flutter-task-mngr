import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_test/screens/login.dart';

class AppFirebaseService {

  AppFirebaseService._privateConstructor();

  static final AppFirebaseService instance =
      AppFirebaseService._privateConstructor();
 
  Future<void> registerUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    debugPrint("Attempting to register user with email: $email");
    try {
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      debugPrint("Registration successful for user: ${response.user?.email}");
    } on Exception catch (e) {
      debugPrint("Registration Failed: ${e.toString()}");
    }
  }


}

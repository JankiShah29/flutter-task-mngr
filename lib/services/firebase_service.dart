import 'package:firebase_auth/firebase_auth.dart';

class AppFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
  
  Future<Map<String, dynamic>> registerUser({
     required String email,
     required String password
  }) async {
    try {
      UserCredential response =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      return {
        'success': true,
        'message': 'User registered successfully',
        'user': response.user?.email,
      };
    
    
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed';
      
      if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak. Please use strong password.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Account already exists with this email.';
      } 
      return {
        'success': false,
        'message': errorMessage,
        'error': e.code,
      };
   
   
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> loginUser({
     required String email,
     required String password
  }) async {
    try {
      UserCredential response =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      return {
        'success': true,
        'message': 'Login successful',
        'user': response.user,
      };
   
   
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed. Please try again.';
    
      if (e.code == 'invalid-credential') {
        errorMessage = 'Email or password is invalid.';
      }
      return {
        'success': false,
        'message': errorMessage,
        'error': e.code,
      };
   
   
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
        'error': e.toString(),
      };
    }
  }
}

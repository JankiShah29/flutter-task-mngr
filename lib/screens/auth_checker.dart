import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_test/screens/dashboard_screen.dart';
import 'package:interview_test/screens/login.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return DashboardScreen(userName: snapshot.data!.email ?? 'User');
        }

        return LoginScreen();
      },
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_test/screens/dashboard_screen.dart';
import 'package:interview_test/screens/register.dart';
import 'package:interview_test/services/firebase_service.dart';
import 'package:interview_test/widgets/bottom_line_auth.dart';
import 'package:interview_test/widgets/email_widget.dart';
import 'package:interview_test/widgets/password_widget.dart';
import 'package:interview_test/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 10),

                    EmailWidget(emailController: emailController),

                    const SizedBox(height: 20),

                    const Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 10),

                    PasswordWidget(
                      passwordController: passwordController,
                      isPasswordHidden: isPasswordHidden,
                      hintText: "Enter password",
                      action: TextInputAction.done,
                    ),

                    const SizedBox(height: 14),

                    PrimaryButton(
                      buttonText: "Login Me!",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                           showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          final result = await AppFirebaseService().loginUser(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString()  
                          );

                          if (mounted) {
                            Navigator.pop(context);
                          
                            if(result['success'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login successful"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              User user = result['user'];

                              Future.delayed(Duration(seconds: 1), () {
                                if(mounted){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardScreen(userName: user.email ?? 'User'),
                                    ),
                                  );
                                }
                              });

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result['message'] ?? "Login failed"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    BottomLineAuth(
                      text1: 'New User ?',
                      text2: 'Create Account',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

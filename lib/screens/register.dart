import 'package:flutter/material.dart';
import 'package:interview_test/screens/login.dart';
import 'package:interview_test/services/firebase_service.dart';
import 'package:interview_test/widgets/bottom_line_auth.dart';
import 'package:interview_test/widgets/email_widget.dart';
import 'package:interview_test/widgets/password_widget.dart';
import 'package:interview_test/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

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
                      "Create Account",
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
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Confirm Password",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 10),

                    PasswordWidget(
                      passwordController: confirmPasswordController,
                      isPasswordHidden: isConfirmPasswordHidden,
                      hintText: "Re-enter password",
                    ),

                    const SizedBox(height: 32),

                    PrimaryButton(
                      buttonText: "Register Me!",
                      onPressed: () {
                        print("Register button pressed : ${emailController.text} - ${passwordController.text} - ${confirmPasswordController.text} ");
                        print("Form Valid : ${_formKey.currentState!.validate()}");
                        if (_formKey.currentState!.validate()) {
                          if(passwordController.text.toString() != confirmPasswordController.text.toString()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }
                          AppFirebaseService.instance.registerUser(
                            emailController.text.toString(), 
                            passwordController.text.toString(), 
                            context
                            );
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    BottomLineAuth(
                      text1: 'Already have account?',
                      text2: 'Login',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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

import 'package:flutter/material.dart';
@immutable
class PasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  bool isPasswordHidden;
  final String hintText;


  PasswordWidget({super.key, required this.passwordController, required this.isPasswordHidden, required this.hintText});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: widget.isPasswordHidden,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter password";
        }

        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            widget.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              widget.isPasswordHidden = !widget.isPasswordHidden;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  final TextEditingController emailController;

  const EmailWidget({super.key, required this.emailController});

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter email";
        }

        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return "Enter valid email";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter email",
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

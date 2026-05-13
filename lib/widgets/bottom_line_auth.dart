import 'package:flutter/material.dart';

class BottomLineAuth extends StatefulWidget {
  final String text1;
  final String text2;
  final VoidCallback onPressed;
  const BottomLineAuth({super.key, required this.text1, required this.text2, required this.onPressed});

  @override
  State<BottomLineAuth> createState() => _BottomLineAuthState();
}

class _BottomLineAuthState extends State<BottomLineAuth> {
  @override
  Widget build(BuildContext context) {
    return       Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.text1,
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: widget.onPressed,
                          child: Text(
                            widget.text2,
                            style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
  }
}
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.emailController,
    required this.hintText,
    this.obscureText = false
  });

  final TextEditingController emailController;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      obscureText: obscureText,
      
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}

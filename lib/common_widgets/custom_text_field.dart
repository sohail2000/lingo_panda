import 'package:flutter/material.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.emailController,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,  
  });

  final TextEditingController emailController;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: emailController,
        obscureText: obscureText,
        validator: validator,  
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: CustomTextStyle.blackRegular14,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
      ),
    );
  }
}

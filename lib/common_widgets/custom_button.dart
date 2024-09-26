import 'package:flutter/material.dart';
import 'package:lingo_panda/styling/custom_colors.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ?  CustomColors.grey:  CustomColors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
      ),
      child: Text(
        text,
        style: CustomTextStyle.whiteRegular14,
      ),
    );
  }
}

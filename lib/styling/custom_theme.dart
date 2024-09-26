import 'package:flutter/material.dart';
import 'package:lingo_panda/styling/custom_colors.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: CustomColors.blue,
      scaffoldBackgroundColor: CustomColors.lightGrey,
      // appBarTheme: AppBarTheme(
      //   backgroundColor: CustomColors.blue,
      //   foregroundColor: CustomColors.lightGrey,
      //   elevation: 4.0,
      //   scrolledUnderElevation: 0.0,
      //   shadowColor: CustomColors.grey.withOpacity(0.5),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.blue, 
          foregroundColor: CustomColors.lightGrey, 
          shadowColor: CustomColors.grey.withOpacity(0.5),
          elevation: 4.0,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), 
          ),
        ),
      ),
    );
  }
}

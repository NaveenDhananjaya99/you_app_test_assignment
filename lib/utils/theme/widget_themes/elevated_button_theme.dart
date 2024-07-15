import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class YouAppElevatedButtonTheme {
  YouAppElevatedButtonTheme._(); // To avoid creating instances

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
     // Transparent background to apply gradient
     // disabledForegroundColor: YouAppColors.darkGrey,

    disabledBackgroundColor: YouAppColors.buttonDisabled,
      // side: const BorderSide(color: YouAppColors.primary),
      // padding: const EdgeInsets.symmetric(vertical: YouAppSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFFFF),
        height: 1.21, // Adjusted line height to match 19.36 / 16
        letterSpacing: -0.23,
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(8),
      // ),
    ),
  );
}


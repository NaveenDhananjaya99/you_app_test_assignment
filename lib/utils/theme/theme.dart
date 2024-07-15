import 'package:flutter/material.dart';
import 'package:you_app_test/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:you_app_test/utils/theme/widget_themes/text_theme.dart';


import '../constants/colors.dart';

class YouAppTheme {
  YouAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: YouAppColors.grey,
    brightness: Brightness.light,
    primaryColor: YouAppColors.primary,
    textTheme: YouAppTextTheme.lightTextTheme,
    // chipTheme: TChipTheme.lightChipTheme,
    // scaffoldBackgroundColor: TColors.white,
    // appBarTheme: TAppBarTheme.lightAppBarTheme,
    // checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    // bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    //  elevatedButtonTheme: YouAppElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    // inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    // datePickerTheme: DatePickerThemeData(
    //   // Specify colors here
    //   backgroundColor: Colors.red,
    //   dayStyle: TextStyle(color: Colors.white),
    //
    // ),
  );


}

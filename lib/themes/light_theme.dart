import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: kWhiteColor,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: kGreyColor,
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: kWhiteColor,
    ),
    backgroundColor: kPrimaryColor,
  ),
  iconTheme: const IconThemeData(
    color: kGreyColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kWhiteColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: kPrimaryColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: kGreyColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: kRedColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: kRedColor,
      ),
    ),
    errorStyle: const TextStyle(
      color: kRedColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: kWhiteColor,
        ),
      ),
      backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
      foregroundColor: const WidgetStatePropertyAll(kWhiteColor),
      overlayColor: WidgetStatePropertyAll(kGreyColor.withOpacity(0.1)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  ),
  scaffoldBackgroundColor: kWhiteColor,
);

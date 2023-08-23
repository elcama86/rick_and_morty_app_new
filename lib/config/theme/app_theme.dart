import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Colors.white;
final scaffoldBackgroundColor = Colors.grey.shade900;
const titleTextColor = Colors.white;
const filledButtonColor = Colors.black;

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.amaticSc().copyWith(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
          titleMedium: GoogleFonts.amaticSc().copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
          titleSmall: GoogleFonts.amaticSc().copyWith(
            fontSize: 20.0,
            color: titleTextColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.amaticSc().copyWith(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: titleTextColor,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: filledButtonColor,
            disabledBackgroundColor: filledButtonColor.withOpacity(0.5),
          ),
        ),
      );
}

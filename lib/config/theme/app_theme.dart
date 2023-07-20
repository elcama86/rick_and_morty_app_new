import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Colors.white;
final scaffoldBackgroundColor = Colors.grey.shade900;

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
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.amaticSc().copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: GoogleFonts.amaticSc().copyWith(
            fontSize: 20.0,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.amaticSc().copyWith(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

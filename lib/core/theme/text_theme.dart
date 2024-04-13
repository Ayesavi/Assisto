import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.inter(
    fontSize: 57,
    height:
        64 / 57, // Calculate line height based on font size and desired ratio
    letterSpacing: -0.25,
  ),
  displayMedium: GoogleFonts.inter(
    fontSize: 45,
    height: 52 / 45,
    letterSpacing: 0.0,
  ),
  displaySmall: GoogleFonts.inter(
    fontSize: 36,
    height: 44 / 36,
    letterSpacing: 0.0,
  ),
  headlineLarge: GoogleFonts.inter(
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: 0.0,
  ),
  headlineMedium: GoogleFonts.inter(
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: 0.0,
  ),
  headlineSmall: GoogleFonts.inter(
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0.0,
  ),
  titleLarge: GoogleFonts.inter(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: 0.0,
  ),
  titleMedium: GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.10,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.10,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.50,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: GoogleFonts.inter(
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.50,
    fontWeight: FontWeight.w400,
  ),
);

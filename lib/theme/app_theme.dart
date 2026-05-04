import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design System: Premium High-Contrast Finance
/// Based on Stitch DESIGN.md specification
class AppTheme {
  // === Primary Colors ===
  static const Color primary = Color(0xFFD0BCFF);
  static const Color onPrimary = Color(0xFF3C0091);
  static const Color primaryContainer = Color(0xFFA078FF);
  static const Color onPrimaryContainer = Color(0xFF340080);
  static const Color inversePrimary = Color(0xFF6D3BD7);

  // === Secondary Colors ===
  static const Color secondary = Color(0xFFDCFDFF);
  static const Color onSecondary = Color(0xFF00373A);
  static const Color secondaryContainer = Color(0xFF00F1FD);
  static const Color onSecondaryContainer = Color(0xFF006A6F);

  // === Tertiary Colors ===
  static const Color tertiary = Color(0xFFFFB2B7);
  static const Color onTertiary = Color(0xFF67001B);
  static const Color tertiaryContainer = Color(0xFFFF516A);
  static const Color onTertiaryContainer = Color(0xFF5B0017);

  // === Surface Colors ===
  static const Color surface = Color(0xFF0B1326);
  static const Color surfaceDim = Color(0xFF0B1326);
  static const Color surfaceBright = Color(0xFF31394D);
  static const Color surfaceContainerLowest = Color(0xFF060E20);
  static const Color surfaceContainerLow = Color(0xFF131B2E);
  static const Color surfaceContainer = Color(0xFF171F33);
  static const Color surfaceContainerHigh = Color(0xFF222A3D);
  static const Color surfaceContainerHighest = Color(0xFF2D3449);
  static const Color onSurface = Color(0xFFDAE2FD);
  static const Color onSurfaceVariant = Color(0xFFCBC3D7);
  static const Color inverseSurface = Color(0xFFDAE2FD);
  static const Color inverseOnSurface = Color(0xFF283044);

  // === Outline ===
  static const Color outline = Color(0xFF958EA0);
  static const Color outlineVariant = Color(0xFF494454);

  // === Error ===
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);

  // === Background ===
  static const Color background = Color(0xFF0B1326);
  static const Color onBackground = Color(0xFFDAE2FD);

  // === Glass Card Style ===
  static Color glassCardBg = const Color(0xFF171F33).withOpacity(0.7);
  static Color glassCardBorder = const Color(0xFF958EA0).withOpacity(0.2);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: primaryContainer,
        onPrimary: onPrimaryContainer,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondaryContainer,
        onSecondary: onSecondaryContainer,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      textTheme: _buildTextTheme(),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: outlineVariant),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryContainer,
        foregroundColor: onPrimaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceContainerLowest.withOpacity(0.95),
        selectedItemColor: primaryContainer,
        unselectedItemColor: outline,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryContainer, width: 2),
        ),
        hintStyle: const TextStyle(color: outline),
      ),
    );
  }

  // Unused - app is dark-only as per Stitch design
  static ThemeData get lightTheme => darkTheme;

  static TextTheme _buildTextTheme() {
    return GoogleFonts.epilogueTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.epilogue(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.5,
        color: onSurface,
      ),
      displayMedium: GoogleFonts.epilogue(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.epilogue(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: onSurface,
      ),
      titleLarge: GoogleFonts.epilogue(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: onSurface,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.6,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: onSurface,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 1.5,
        color: outline,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WasteWiseTheme {
  // Primary Colors - Inspired by nature and eco-friendly theme
  static const Color primaryGreen = Color(0xFF2ECC71);
  static const Color secondaryGreen = Color(0xFF27AE60);
  static const Color lightGreen = Color(0xFFE8F8F5);
  static const Color darkGreen = Color(0xFF1E8449);

  // Supporting Colors
  static const Color accentBlue = Color(0xFF3498DB);
  static const Color accentOrange = Color(0xFFF39C12);
  static const Color accentPurple = Color(0xFF9B59B6);
  static const Color accentRed = Color(0xFFE74C3C);

  // Neutral Colors - Apple HIG inspired
  static const Color primaryText = Color(0xFF1C1C1E);
  static const Color secondaryText = Color(0xFF8E8E93);
  static const Color tertiaryText = Color(0xFFC7C7CC);
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Glass Effect Colors
  static const Color glassBackground = Color(0xFFFFFFFF);
  static const Color glassStroke = Color(0xFFE5E5EA);

  // Gamification Colors
  static const Color goldStar = Color(0xFFFFD700);
  static const Color silverStar = Color(0xFFC0C0C0);
  static const Color bronzeStar = Color(0xFFCD7F32);

  static TextTheme get textTheme => TextTheme(
    // Headlines
    displayLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: primaryText,
      height: 1.2,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: primaryText,
      height: 1.2,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: primaryText,
      height: 1.3,
    ),

    // Titles
    titleLarge: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: primaryText,
      height: 1.3,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryText,
      height: 1.4,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primaryText,
      height: 1.4,
    ),

    // Body Text
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryText,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: primaryText,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondaryText,
      height: 1.4,
    ),

    // Labels
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryText,
      height: 1.3,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: primaryText,
      height: 1.3,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: secondaryText,
      height: 1.2,
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF2ECC71, {
      50: lightGreen,
      100: const Color(0xFFD4F4DD),
      200: const Color(0xFFA9E9BB),
      300: const Color(0xFF7FDE99),
      400: const Color(0xFF54D377),
      500: primaryGreen,
      600: const Color(0xFF25A25A),
      700: const Color(0xFF1C7A43),
      800: const Color(0xFF13512C),
      900: const Color(0xFF0A2916),
    }),
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: secondaryGreen,
      surface: surface,
      background: background,
      error: accentRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: primaryText,
      onBackground: primaryText,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    cardColor: cardBackground,
    textTheme: textTheme,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge,
      iconTheme: const IconThemeData(color: primaryText, size: 24),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: glassStroke, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      elevation: 0,
      selectedItemColor: primaryGreen,
      unselectedItemColor: secondaryText,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: glassStroke, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: glassStroke, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentRed, width: 1),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: secondaryText),
    ),
  );

  // Cupertino Theme for iOS-like components
  static CupertinoThemeData get cupertinoTheme => CupertinoThemeData(
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: background,
    barBackgroundColor: surface,
    textTheme: CupertinoTextThemeData(
      primaryColor: primaryText,
      textStyle: textTheme.bodyMedium!,
      actionTextStyle: textTheme.bodyMedium!.copyWith(
        color: primaryGreen,
        fontWeight: FontWeight.w500,
      ),
      tabLabelTextStyle: textTheme.labelSmall!,
      navTitleTextStyle: textTheme.titleLarge!,
      navLargeTitleTextStyle: textTheme.displaySmall!,
    ),
  );

  // Custom Decorations for Glass Effect
  static BoxDecoration get glassCardDecoration => BoxDecoration(
    color: glassBackground.withOpacity(0.9),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: glassStroke.withOpacity(0.2), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration get primaryGradientDecoration => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryGreen, secondaryGreen],
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: primaryGreen.withOpacity(0.3),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
}

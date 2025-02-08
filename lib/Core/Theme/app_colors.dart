import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3);    // Blue
  static const Color primaryDark = Color(0xFF1976D2); // Dark Blue
  static const Color primaryLight = Color(0xFF64B5F6); // Light Blue
  static const Color accent = Color(0xFFFFA726);      // Orange

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color textDark = Color(0xFF000000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);

  // Shadow Colors
  static const Color shadow = Color(0x1F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2196F3),
    Color(0xFF64B5F6),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFFFA726),
    Color(0xFFFFB74D),
  ];
}

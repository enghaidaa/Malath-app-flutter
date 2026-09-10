import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData buildTheme({
    required bool isDark,
    required double fontSize,
  }) {
    final baseTheme = isDark ? darkTheme : lightTheme;

    final safeFontSize = fontSize.isFinite && fontSize > 0 ? fontSize : 18.0;

    final scaleFactor = safeFontSize / 18.0;

    return baseTheme.copyWith(
      textTheme: _scaleTextTheme(
        baseTheme.textTheme,
        scaleFactor,
      ),
      primaryTextTheme: _scaleTextTheme(
        baseTheme.primaryTextTheme,
        scaleFactor,
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle: baseTheme.appBarTheme.titleTextStyle?.copyWith(
          fontSize: (baseTheme.appBarTheme.titleTextStyle?.fontSize ?? 20) *
              scaleFactor,
        ),
      ),
    );
  }

  static TextTheme _scaleTextTheme(
    TextTheme baseTheme,
    double scaleFactor,
  ) {
    return baseTheme.copyWith(
      displayLarge: _scaleStyle(baseTheme.displayLarge, scaleFactor, 57),
      displayMedium: _scaleStyle(baseTheme.displayMedium, scaleFactor, 45),
      displaySmall: _scaleStyle(baseTheme.displaySmall, scaleFactor, 36),
      headlineLarge: _scaleStyle(baseTheme.headlineLarge, scaleFactor, 32),
      headlineMedium: _scaleStyle(baseTheme.headlineMedium, scaleFactor, 28),
      headlineSmall: _scaleStyle(baseTheme.headlineSmall, scaleFactor, 24),
      titleLarge: _scaleStyle(baseTheme.titleLarge, scaleFactor, 22),
      titleMedium: _scaleStyle(baseTheme.titleMedium, scaleFactor, 16),
      titleSmall: _scaleStyle(baseTheme.titleSmall, scaleFactor, 14),
      bodyLarge: _scaleStyle(baseTheme.bodyLarge, scaleFactor, 16),
      bodyMedium: _scaleStyle(baseTheme.bodyMedium, scaleFactor, 14),
      bodySmall: _scaleStyle(baseTheme.bodySmall, scaleFactor, 12),
      labelLarge: _scaleStyle(baseTheme.labelLarge, scaleFactor, 14),
      labelMedium: _scaleStyle(baseTheme.labelMedium, scaleFactor, 12),
      labelSmall: _scaleStyle(baseTheme.labelSmall, scaleFactor, 11),
    );
  }

  static TextStyle _scaleStyle(
    TextStyle? style,
    double scaleFactor,
    double fallbackSize,
  ) {
    final baseStyle = style ?? const TextStyle();
    final baseSize = baseStyle.fontSize ?? fallbackSize;

    return baseStyle.copyWith(
      fontSize: baseSize * scaleFactor,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppStyles.fontFamily,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.divider,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.divider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
      ),
      dividerColor: AppColors.divider,
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppStyles.fontFamily,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.darkDivider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.darkPrimary,
            width: 2,
          ),
        ),
      ),
      dividerColor: AppColors.darkDivider,
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

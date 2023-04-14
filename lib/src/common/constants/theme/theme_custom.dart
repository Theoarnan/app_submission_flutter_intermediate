import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCustom {
  /// Colors
  static const Color primaryColor = Color(0xFF059CEB);
  static const Color secondaryColor = Color(0xFFBDBDBD);
  static const Color yellowColor = Color(0xFFFEB100);
  static const Color yellowSoftColor = Color(0xFFFFDF81);
  static const Color redColor = Color(0xFFDE4D38);
  static const Color greenColor = Color(0xFF7CB456);
  static const Color darkColor = Color(0xFF1D1E1F);

  /// Typography
  static TextStyle titleTS = TextStyle(
    color: darkColor,
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
  );
  static TextStyle subtitleTS = TextStyle(
    color: darkColor,
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
  );
  static TextStyle bodyLargeTS = TextStyle(
    color: darkColor,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
  static TextStyle bodyMediumTS = TextStyle(
    color: darkColor,
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
  );
  static TextStyle bodySmallTS = TextStyle(
    color: darkColor,
    fontWeight: FontWeight.normal,
    fontSize: 12.sp,
  );

  /// ThemeData
  static ThemeData themeData() => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          error: redColor,
        ),
        textTheme: TextTheme(
          labelLarge: titleTS,
          labelSmall: subtitleTS,
          bodyLarge: bodyLargeTS,
          bodyMedium: bodyMediumTS,
          bodySmall: bodySmallTS,
        ),
      );
}

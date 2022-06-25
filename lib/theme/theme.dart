import 'package:flutter/material.dart';

ColorScheme colorScheme = const ColorScheme(
  primary: Color(0xFF4C154D),
  primaryContainer: Color(0xFF5E2D5C),
  secondary: Color(0xFFDB88CD),
  secondaryContainer: Color(0xFFCD7DBF),
  surface: Color(0xFFFFFFFF),
  background: Color(0xFFFFF5FD),
  error: Colors.red,
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onBackground: Color(0xFF4C154D),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

class CustomTheme {
  static Color get primary => const Color(0xFF4C154D);

  static Color get primaryVariant => const Color(0xFF5E2D5C);

  static Color get secondary => const Color(0xFFDB88CD);

  static Color get secondaryVariant => const Color(0xFFF8CEF1);

  static Color get card => const Color(0xFFFFFFFF);

  static Color get background => const Color(0xFFFFF6FE);

  static Color get t1 => const Color(0xFF000000);

  static Color get t2 => const Color(0xFF787878);

  static Color get t3 => const Color(0xFFFFFFFF);

  static Color get cardShadow => const Color(0xFFFFD0F6).withOpacity(0.3);
}

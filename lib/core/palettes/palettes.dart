import 'package:flutter/material.dart';

abstract class AppPalette {
  static const Color primaryColorLight = Color(0xFF2764CC);
  static const Color kFormFieldFillColor = Colors.white;
  static const Color kTextColorLight = Color(0XFF111213);
  static const Color kBodyTextColorLight = Color(0XFF545A60);
  static const Color kBodyTextColorVariantLight = Color(0XFFA4A4A4);
  static const Color kChipBackgroundColorLight = Color(0xFFEFF4FF);
  static const Color kCardBackgroundColorLight = Color(0xFFFDFDFD);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.primaryColorLight,
    onPrimary: Colors.white,
    primaryContainer: null,
    onPrimaryContainer: null,
    secondary: Color(0xff03dac6),
    onSecondary: Colors.black,
    secondaryContainer: null,
    onSecondaryContainer: null,
    tertiary: null,
    onTertiary: null,
    tertiaryContainer: null,
    onTertiaryContainer: null,
    error: Color(0xffb00020),
    onError: Colors.white,
    errorContainer: null,
    onErrorContainer: null,
    background: Color(0xFFF3F6FD),
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceVariant: null,
    onSurfaceVariant: null,
    outline: null,
    shadow: null,
    inverseSurface: null,
    onInverseSurface: null,
    inversePrimary: null,
    surfaceTint: null,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.primaryColorLight,
    onPrimary: Colors.white,
    primaryContainer: null,
    onPrimaryContainer: null,
    secondary: Color(0xff03dac6),
    onSecondary: Colors.black,
    secondaryContainer: null,
    onSecondaryContainer: null,
    tertiary: null,
    onTertiary: null,
    tertiaryContainer: null,
    onTertiaryContainer: null,
    error: Color(0xffb00020),
    onError: Colors.white,
    errorContainer: null,
    onErrorContainer: null,
    background: Colors.red,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceVariant: null,
    onSurfaceVariant: null,
    outline: null,
    shadow: null,
    inverseSurface: null,
    onInverseSurface: null,
    inversePrimary: null,
    surfaceTint: null,
  );
}

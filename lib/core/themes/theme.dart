import 'package:flutter/material.dart';

part 'theme_dark.dart';
part 'theme_light.dart';

class ThemeManager{
  static get light => _lightTheme;
  static get dark => _darkTheme;
}
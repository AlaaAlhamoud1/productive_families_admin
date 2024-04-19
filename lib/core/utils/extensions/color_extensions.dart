import 'package:flutter/material.dart';

extension Hex on Color {
  bool isDark() => getBrightness() < 128.0;

  bool isLight() => !isDark();

  double getBrightness() => (red * 299 + green * 587 + blue * 114) / 1000;

  double getLuminance() => computeLuminance();
}

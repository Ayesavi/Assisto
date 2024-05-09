import 'package:assisto/core/theme/theme.dart';
import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  ColorFamily appGreen(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme ? MaterialTheme.green.dark : MaterialTheme.green.light;
  }

  ColorFamily appLushGreen(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme
        ? MaterialTheme.lushGreen.dark
        : MaterialTheme.lushGreen.light;
  }

  ColorFamily appRed(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme ? MaterialTheme.red.dark : MaterialTheme.red.light;
  }

  ColorFamily appYellow(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme ? MaterialTheme.yellow.dark : MaterialTheme.yellow.light;
  }
}

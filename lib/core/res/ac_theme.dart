import 'package:flutter/material.dart';

import 'ac_colors.dart';

class AcTheme {
  static ThemeData getAppTheme() {
    final ThemeData theme = ThemeData();
    return theme.copyWith(
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      disabledColor: AcColors.disableGrey,
      colorScheme: theme.colorScheme.copyWith(
        secondary: AcColors.primary,
        primary: AcColors.primary,
      ),
    );
  }
}

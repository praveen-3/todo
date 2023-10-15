import 'package:flutter/material.dart';
import 'package:todo_flutter/core/res/ac_colors.dart';
import 'package:todo_flutter/core/res/styles/ac_text_styles.dart';

import '../../../../core/res/dimens.dart';

class CustomProgressWidget {
  static getCustomProgressDialogWithMessage(String message) {
    final CircularProgressIndicator loaderView = CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AcColors.primary));
    final messageView =
        Text(message, style: AcTextStyles.getBlack8716dpRegTextStyle());
    final spaceView = SizedBox(
      height: Dimens.dimen_20,
    );
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [loaderView, spaceView, messageView]));
  }
}

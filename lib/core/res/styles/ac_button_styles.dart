import 'package:flutter/material.dart';

import '../ac_colors.dart';
import 'ac_text_styles.dart';

class AcButtonStyles {
  static ButtonStyle getBlack87PrimaryButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getBlack8716dpRegTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getColorAccentPrimaryButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getWhite16dpSemiBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getColorAccentPrimaryLightButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primaryLight),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getWhite16dpSemiBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getWhiteGreyButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.grey),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getBlack8716dpRegTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getBlack60Bold14WhiteButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.black60),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getBlack6014dpBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getLightBlackRegular10WhiteButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.lightBlack),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getBlack4010dpRegTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getPrimaryBold12WhiteButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getPrimary12dpBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getWhiteBold12WhiteButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getWhite12dpBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getWhiteBold14PrimaryButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getWhite14dpBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getColorAccentTransparentButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getWhite16dpSemiBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getPrimaryBold14Black87ButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AcColors.primary),
      foregroundColor: MaterialStateProperty.all<Color>(AcColors.black_87),
      textStyle: MaterialStateProperty.all<TextStyle>(
          AcTextStyles.getBlack8714dpBoldTextStyle()),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static ButtonStyle getCustomButtonStyle(
      Color backgroundColor, Color foregroundColor, TextStyle buttonTextStyle) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      foregroundColor: MaterialStateProperty.all<Color>(
          buttonTextStyle.color ?? foregroundColor),
      textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
      splashFactory: NoSplash.splashFactory,
    );
  }
}

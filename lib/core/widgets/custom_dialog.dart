import 'package:flutter/material.dart';
import 'package:todo_flutter/core/widgets/ac_image_view.dart';

import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import '../res/styles/ac_button_styles.dart';
import '../res/styles/ac_text_styles.dart';
import '../res/dimens.dart';
import '../utils/app_utils.dart';

class CustomDialog {
  static bool isVisible = false;

  static Future<dynamic> getSimpleDialogWithSingleButton(
    BuildContext context,
    String message,
    String buttonText,
    Function() onPressed,
    Function() backPressed,
    bool invisibleButton, {
    bool hideCancelButton = false,
    Function()? onWillScope,
  }) {
    final Widget textPortion = Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_20),
          child: Text(
            message,
            textAlign: TextAlign.left,
            style: AcTextStyles.getBlack8716dpSemiBoldTextStyle(),
          ),
        ),
      ),
    );

    final buttonShape = MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.dimen_40)),
      ),
    );

    final Widget buttonPortion = Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimens.dimen_45,
      ),
      child: Visibility(
        visible: !invisibleButton,
        child: SizedBox(
          width: Dimens.dimen_180,
          height: Dimens.dimen_40,
          child: TextButton(
              style: AcButtonStyles.getBlack87PrimaryButtonStyle().copyWith(
                shape: buttonShape,
                textStyle: MaterialStateProperty.all<TextStyle>(
                    AcTextStyles.getWhite14dpBoldTextStyle()),
              ),
              onPressed: () {
                AppUtils.popScreen(context);
                onPressed();
                isVisible = false;
              },
              child: Text(buttonText)),
        ),
      ),
    );

    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dimen_20),
      ),
      child: SizedBox(
        height: Dimens.dimen_400,
        width: Dimens.dimen_400,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !hideCancelButton,
                  child: GestureDetector(
                    onTap: () {
                      AppUtils.popScreen(context);
                      backPressed();
                      isVisible = false;
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimens.dimen_20),
                      child: AcImageView.fromLocal(AcImages.cancelButton),
                    ),
                  ),
                ),
              ],
            ),
            textPortion,
            buttonPortion,
          ],
        ),
      ),
    );

    if (isVisible) {
      return Future.value(null);
    } else {
      isVisible = true;
      return Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black54,
          pageBuilder: (BuildContext context, _, __) {
            return WillPopScope(
              child: dialog,
              onWillPop: () async {
                isVisible = false;
                if (onWillScope != null) {
                  onWillScope();
                }
                return true;
              },
            );
          },
        ),
      );
    }
  }

  static Future<dynamic> getNonDismissibleDialogWithSingleButton(
      BuildContext context,
      String message,
      String buttonText,
      Function() onPressed,
      bool invisibleButton) {
    final Widget textPortion = Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_20),
          child: Text(
            message,
            textAlign: TextAlign.left,
            style: AcTextStyles.getBlack8716dpSemiBoldTextStyle(),
          ),
        ),
      ),
    );

    final buttonShape = MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.dimen_40)),
      ),
    );

    final Widget buttonPortion = Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimens.dimen_45,
      ),
      child: Visibility(
        visible: !invisibleButton,
        child: SizedBox(
          width: Dimens.dimen_180,
          height: Dimens.dimen_40,
          child: TextButton(
              style: AcButtonStyles.getBlack87PrimaryButtonStyle().copyWith(
                shape: buttonShape,
                textStyle: MaterialStateProperty.all<TextStyle>(
                    AcTextStyles.getWhite14dpBoldTextStyle()),
              ),
              onPressed: () {
                onPressed();
                isVisible = false;
              },
              child: Text(buttonText)),
        ),
      ),
    );

    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dimen_20),
      ),
      child: SizedBox(
        height: Dimens.dimen_400,
        width: Dimens.dimen_400,
        child: Column(
          children: [
            textPortion,
            buttonPortion,
          ],
        ),
      ),
    );

    if (isVisible) {
      return Future.value(null);
    } else {
      isVisible = true;
      return Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black54,
          pageBuilder: (BuildContext context, _, __) {
            return WillPopScope(
              child: dialog,
              onWillPop: () async {
                return false;
              },
            );
          },
        ),
      );
    }
  }

  static Future<dynamic> getSimpleDialog(
    BuildContext context,
    String title,
    String message,
    String positiveButtonText,
    String negativeButtonText,
    Function() onPositivePressed,
    Function() onNegativePressed,
    Function() backPressed, {
    bool hideNegativeButton = false,
    bool hidePositiveButton = false,
    bool hideCancelButton = false,
    TextAlign messageAlign = TextAlign.left,
    TextStyle? messageStyle,
  }) {
    //
    //Assining Message style

    messageStyle ??= AcTextStyles.getBlack8716dpSemiBoldTextStyle();

    final Widget textPortion = Visibility(
      visible: message.isNotEmpty,
      child: Expanded(
        child: Container(
          padding: EdgeInsets.only(
            left: Dimens.dimen_40,
            right: Dimens.dimen_40,
            bottom: Dimens.dimen_20,
          ),
          child: Text(message, textAlign: messageAlign, style: messageStyle),
        ),
      ),
    );

    final Widget titleTextPortion = Visibility(
      visible: title.isNotEmpty,
      child: Container(
        padding: EdgeInsets.only(
          right: Dimens.dimen_20,
          bottom: Dimens.dimen_20,
          left: Dimens.dimen_20,
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: AcTextStyles.getBlack8722dpSemiBoldTextStyle()),
      ),
    );

    final postitiveButtonShape =
        MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.dimen_40)),
      ),
    );

    final Widget positiveButtonPortion = Visibility(
      visible: !hidePositiveButton,
      child: Container(
        width: Dimens.dimen_180,
        height: Dimens.dimen_40,
        margin: EdgeInsets.only(bottom: Dimens.dimen_45),
        child: TextButton(
          style: AcButtonStyles.getBlack87PrimaryButtonStyle().copyWith(
            shape: postitiveButtonShape,
            textStyle: MaterialStateProperty.all<TextStyle>(
                AcTextStyles.getWhite14dpBoldTextStyle()),
          ),
          onPressed: () {
            AppUtils.popScreen(context);
            onPositivePressed();
            isVisible = false;
          },
          child: Text(positiveButtonText),
        ),
      ),
    );

    final negativeButtonShape =
        MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.dimen_40),
        ),
        side: BorderSide(color: AcColors.primary),
      ),
    );

    final Widget negativeButtonPortion = Visibility(
      visible: !hideNegativeButton,
      child: Container(
        width: Dimens.dimen_180,
        height: Dimens.dimen_40,
        margin: EdgeInsets.only(bottom: Dimens.dimen_22),
        child: TextButton(
          style: AcButtonStyles.getBlack87PrimaryButtonStyle().copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(AcColors.white),
            shape: negativeButtonShape,
            textStyle: MaterialStateProperty.all<TextStyle>(
                AcTextStyles.getPrimary14dpBoldTextStyle()),
          ),
          onPressed: () {
            AppUtils.popScreen(context);
            onNegativePressed();
            isVisible = false;
          },
          child: Text(
            negativeButtonText,
            style: AcTextStyles.getPrimary14dpBoldTextStyle(),
          ),
        ),
      ),
    );

    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_20)),
      child: SizedBox(
        height: Dimens.dimen_400 -
            (title.isEmpty ? Dimens.dimen_40 : Dimens.dimen_0),
        width: Dimens.dimen_400,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimens.dimen_20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: !hideCancelButton,
                    child: GestureDetector(
                      onTap: () {
                        AppUtils.popScreen(context);
                        backPressed();
                        isVisible = false;
                      },
                      child: AcImageView.fromLocal(AcImages.cancelButton),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimens.dimen_30),
            titleTextPortion,
            textPortion,
            negativeButtonPortion,
            positiveButtonPortion,
          ],
        ),
      ),
    );

    if (isVisible) {
      return Future.value(null);
    } else {
      isVisible = true;
      return Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierColor: AcColors.black54,
          pageBuilder: (BuildContext context, _, __) {
            return dialog;
          },
        ),
      );
    }
  }
}

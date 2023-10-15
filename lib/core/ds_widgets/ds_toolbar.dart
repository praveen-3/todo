import 'package:flutter/material.dart';
import 'package:todo_flutter/core/utils/app_utils.dart';

import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import '../res/dimens.dart';
import '../res/styles/ac_text_styles.dart';
import '../widgets/ac_image_view.dart';

class DSToolBar {
  static AppBar getSimpleActivityBar(BuildContext context, String header,
      {List<Widget>? actions, Function? onBackPressed}) {
    return AppBar(
      shape: const Border(bottom: BorderSide(color: AcColors.colorede7fa)),
      leadingWidth: Dimens.dimen_50,
      leading: IconButton(
        splashColor: AcColors.black,
        icon: AcImageView.fromLocal(AcImages.icBackArrow),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed();
          } else {
            AppUtils.popScreen(context);
          }
        },
      ),
      actions: actions,
      centerTitle: false,
      elevation: Dimens.dimen_0,
      backgroundColor: AcColors.black,
      titleSpacing: 0,
      title: Text(
        header,
        style: AcTextStyles.getBlack8716dpSemiBoldTextStyle(),
      ),
    );
  }
}

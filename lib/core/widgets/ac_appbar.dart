import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_flutter/core/res/ac_images.dart';
import 'package:todo_flutter/core/res/dimens.dart';
import 'package:todo_flutter/core/utils/app_utils.dart';
import 'package:todo_flutter/core/widgets/entities/ac_image_view_entity.dart';

import '../res/ac_colors.dart';
import '../res/styles/ac_text_styles.dart';
import 'ac_image_view.dart';
import 'entities/ac_image_entity.dart';

class AcAppBar {
  static AppBar getSimpleActivityBar(BuildContext context, String header,
      {List<Widget>? actions, Function? onBackPressed}) {
    return AppBar(
      leadingWidth: Dimens.dimen_50,
      leading: GestureDetector(
        onTap: () {
          if (onBackPressed != null) {
            onBackPressed();
          } else {
            AppUtils.popScreen(context);
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            right: Dimens.dimen_14,
            left: Dimens.dimen_14,
            bottom: Dimens.dimen_14,
            top: Dimens.dimen_14,
          ),
          child: AcImageView(
            AcImageViewEntity(
              AcImageEntity(
                imageName: AcImages.icBackArrow,
              ),
            ),
          ),
        ),
      ),
      actions: actions,
      centerTitle: false,
      elevation: Dimens.dimen_3,
      shadowColor: AcColors.greyShade6,
      backgroundColor: AcColors.primary,
      titleSpacing: 0,
      title: Text(
        header,
        style: AcTextStyles.getWhite16dpSemiBoldTextStyle(),
      ),
    );
  }

  static AppBar getHomeActivityBar(BuildContext context, String header,
      {List<Widget>? actions, Function? onPressed}) {
    return AppBar(
      leadingWidth: Dimens.dimen_50,
      leading: IconButton(
        icon: SvgPicture.asset(
          AcImages.icHamburger,
          height: Dimens.dimen_12_5,
          width: Dimens.dimen_12_5,
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else {
            AppUtils.popScreen(context);
          }
        },
      ),
      actions: actions,
      centerTitle: false,
      elevation: Dimens.dimen_3,
      shadowColor: AcColors.greyShade6,
      backgroundColor: AcColors.primary,
      titleSpacing: 0,
      title: Text(
        header,
        style: AcTextStyles.getWhite16dpSemiBoldTextStyle(),
      ),
    );
  }

  static AppBar getTransparentActivityBar(BuildContext context, String header,
      {bool isBlueIcon = false,
      List<Widget>? actions,
      Function()? onBackPress,
      Color? backgroundColor}) {
    return AppBar(
      leading: IconButton(
        icon: (isBlueIcon
            ? SvgPicture.asset(
                AcImages.icAccentBackButton,
                height: Dimens.dimen_12_5,
                width: Dimens.dimen_12_5,
              )
            : Image.asset(
                AcImages.backButton,
                height: Dimens.dimen_12_5,
                width: Dimens.dimen_12_5,
              )),
        onPressed: () {
          if (onBackPress != null) {
            onBackPress();
          } else {
            AppUtils.popScreen(context);
          }
        },
      ),
      actions: actions,
      centerTitle: false,
      elevation: Dimens.dimen_0,
      backgroundColor: backgroundColor ?? AcColors.transparent,
      titleSpacing: 0,
      title: Text(
        header,
        style: AcTextStyles.getPrimary16dpSemiBoldTextStyle(),
      ),
    );
  }

  static AppBar getLoggedInActivityBar(BuildContext context, String header,
      {List<Widget>? actions}) {
    return AppBar(
      leadingWidth: Dimens.dimen_50,
      leading: IconButton(
        icon: SvgPicture.asset(
          AcImages.icAccentBackButton,
          height: Dimens.dimen_12_5,
          width: Dimens.dimen_12_5,
        ),
        onPressed: () {},
      ),
      actions: actions,
      centerTitle: false,
      elevation: Dimens.dimen_1,
      backgroundColor: AcColors.greyShade5,
      titleSpacing: 0,
      title: Text(
        header,
        style: AcTextStyles.getPrimary16dpSemiBoldTextStyle(),
      ),
    );
  }
}

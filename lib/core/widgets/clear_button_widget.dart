import 'package:flutter/material.dart';

import '../../../../core/res/dimens.dart';
import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import 'ac_image_view.dart';

class ClearButton extends StatelessWidget {
  final Function()? cancelButtonInteraction;
  final String clearButtonIcon;

  const ClearButton(
    this.cancelButtonInteraction, {
    super.key,
    this.clearButtonIcon = AcImages.cancelButtonLightGrey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cancelButtonInteraction,
      child: Container(
        padding: EdgeInsets.only(
          right: Dimens.dimen_10,
          left: Dimens.dimen_10,
          bottom: Dimens.dimen_2,
          top: Dimens.dimen_2,
        ),
        color: AcColors.transparent,
        child: AcImageView.fromLocal(clearButtonIcon),
      ),
    );
  }
}

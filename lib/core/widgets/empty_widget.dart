import 'package:flutter/material.dart';

import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import '../res/styles/ac_text_styles.dart';
import 'ac_image_view.dart';

// ignore: must_be_immutable
class EmptyWidget extends StatelessWidget {
  String text;

  EmptyWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AcColors.blueBG,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AcImageView.fromLocal(AcImages.icEmptyImage),
            Text(
              text,
              style: AcTextStyles.getBlack8718dpRegTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

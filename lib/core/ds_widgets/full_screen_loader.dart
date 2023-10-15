import 'package:flutter/material.dart';

import '../res/dimens.dart';
import '../utils/hb_images_util.dart';

class ProgressLoader {
  static getFullScreenLoader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_94),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: HBImagesUtil.getLoader(wrapInArray: true),
        ),
      ),
    );
  }
}

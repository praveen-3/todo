import 'package:flutter/material.dart';

import '../widgets/ac_image_view.dart';

// ignore: must_be_immutable
class DSImageView extends StatelessWidget {
  String? image;

  DSImageView(this.image, {super.key});
  @override
  Widget build(BuildContext context) {
    return image != null ? AcImageView.fromLocal(image!) : Container();
  }
}

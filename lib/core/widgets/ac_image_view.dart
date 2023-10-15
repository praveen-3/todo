import 'package:flutter/material.dart';

import '../utils/hb_images_util.dart';
import 'entities/ac_image_entity.dart';
import 'entities/ac_image_view_entity.dart';

class AcImageView extends StatefulWidget {
  final AcImageViewEntity hbImageViewEntity;

  AcImageView(this.hbImageViewEntity);

  AcImageView.fromLocal(String localImage,
      {Widget? placeholder, double? height, double? width})
      : hbImageViewEntity = AcImageViewEntity(
            AcImageEntity(imageName: localImage),
            placeholder: placeholder,
            height: height,
            width: width);

  @override
  _HBImageView createState() => _HBImageView(hbImageViewEntity);
}

class _HBImageView extends State<AcImageView> {
  final AcImageViewEntity hbImageViewEntity;

  Future<Widget>? _image;

  _HBImageView(this.hbImageViewEntity);

  @override
  Widget build(BuildContext context) {
    _image = HBImagesUtil.getImage(hbImageViewEntity, context);
    return FutureBuilder<Widget>(
      future: _image, // a previously-obtained Future<Widget> or null
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        Widget child;
        if (snapshot.hasData && snapshot.data != null)
          child = snapshot.data!;
        else
          child = hbImageViewEntity.placeholder ?? SizedBox.shrink();
        return child;
      },
    );
  }
}

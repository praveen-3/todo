import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'ac_image_entity.dart';

class AcImageViewEntity extends Equatable {
  final AcImageEntity restfulImage;
  final Widget? customLoader;
  final Widget? placeholder;
  final double? height;
  final double? width;
  final BoxFit? fit;

  AcImageViewEntity(this.restfulImage,
      {this.placeholder, this.height, this.width, this.fit, this.customLoader});

  @override
  List<Object?> get props =>
      [restfulImage, placeholder, height, width, fit, customLoader];
}

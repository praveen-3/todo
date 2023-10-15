import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../constants/application_constants.dart';
import '../enums/image_type.dart';
import '../logger/enum/logger_value.dart';
import '../logger/logger.dart';
import '../res/ac_images.dart';
import '../widgets/entities/ac_image_view_entity.dart';

class HBImagesUtil {
  static Future<Widget> getImage(
      AcImageViewEntity hbImageViewEntity, BuildContext context) async {
    if (hbImageViewEntity.restfulImage.imageName != null) {
      bool result = await _doesImageExists(
          context, hbImageViewEntity.restfulImage.imageName!);
      if (result) {
        return Future.value(_getImageFromAssets(
            hbImageViewEntity.restfulImage.imageName!, hbImageViewEntity));
      } else {
        return Future.value(
            _getImageFromNetworkOrPlaceholder(hbImageViewEntity));
      }
    } else {
      return Future.value(_getImageFromNetworkOrPlaceholder(hbImageViewEntity));
    }
  }

  static Widget _getImageFromNetworkOrPlaceholder(
      AcImageViewEntity hbImageViewEntity) {
    if (hbImageViewEntity.restfulImage.imageUrl != null) {
      return _getImageFromNetworkForUrl(
          hbImageViewEntity.restfulImage.imageUrl!, hbImageViewEntity);
    } else if (hbImageViewEntity.placeholder != null) {
      return hbImageViewEntity.placeholder!;
    } else {
      return const SizedBox.shrink();
    }
  }

  static Future<Set<String>> _getAssetImagesPath(BuildContext context) async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    Set<String> images = (json.decode(manifestJson) as Map<String, dynamic>)
        .keys
        .where((String key) =>
            key.startsWith(ApplicationConstants.IMAGES_DIR_LOCATION))
        .toSet();

    return Future.value(images);
  }

  static Set<String>? _assetImages;

  static Future<bool> _doesImageExists(
      BuildContext context, String imageName) async {
    _assetImages ??= await _getAssetImagesPath(context);
    return _assetImages!
        .contains(ApplicationConstants.IMAGES_DIR_LOCATION + imageName);
  }

  static ImageType _getImageType(String string) {
    var stringSplit = string.split(".");
    var lastStr = stringSplit.lastOrNull;
    return ImageType.values
            .firstWhereOrNull((imageType) => imageType.value == lastStr) ??
        ImageType.PNG;
  }

  static Widget _getImageFromAssets(
      String imageName, AcImageViewEntity hbImageViewEntity) {
    final imageType = _getImageType(imageName);
    switch (imageType) {
      case ImageType.SVG:
        return _getSVGImageFromAssets(imageName, hbImageViewEntity);
      case ImageType.JPEG:
      case ImageType.JPG:
      case ImageType.PNG:
        return _getOtherImageFromAssets(imageName, hbImageViewEntity);
    }
  }

  static Widget _getOtherImageFromAssets(
      String imageName, AcImageViewEntity hbImageViewEntity) {
    return Image.asset(
      ApplicationConstants.IMAGES_DIR_LOCATION + imageName,
      width: hbImageViewEntity.width,
      height: hbImageViewEntity.height,
      fit: hbImageViewEntity.fit ?? BoxFit.contain,
      errorBuilder: hbImageViewEntity.placeholder != null
          ? (BuildContext context, Object exception, StackTrace? stackTrace) {
              Logger.log(
                  error: exception,
                  stackTrace: stackTrace,
                  logValue: LoggerValue.FIREBASE_CRASHLYTICS);
              return hbImageViewEntity.placeholder!;
            }
          : null,
    );
  }

  static Widget _getSVGImageFromAssets(
      String imageName, AcImageViewEntity hbImageViewEntity) {
    return SvgPicture.asset(
        ApplicationConstants.IMAGES_DIR_LOCATION + imageName,
        width: hbImageViewEntity.width,
        height: hbImageViewEntity.height,
        fit: hbImageViewEntity.fit ?? BoxFit.contain,
        placeholderBuilder: hbImageViewEntity.placeholder != null
            ? (BuildContext context) => hbImageViewEntity.placeholder!
            : null);
  }

  static Widget _getImageFromNetworkForUrl(
      String imageUrl, AcImageViewEntity hbImageViewEntity) {
    final imageType = _getImageType(imageUrl);
    switch (imageType) {
      case ImageType.SVG:
        Widget image = _getSVGImageFromNetwork(imageUrl, hbImageViewEntity);
        return image;
      case ImageType.JPEG:
      case ImageType.JPG:
      case ImageType.PNG:
        Widget image = _getOtherImageFromNetwork(imageUrl, hbImageViewEntity);
        return image;
    }
  }

  static Widget _getSVGImageFromNetwork(
      String imageUrl, AcImageViewEntity hbImageViewEntity) {
    var image = SvgPicture.network(
      imageUrl,
      width: hbImageViewEntity.width,
      height: hbImageViewEntity.height,
      fit: hbImageViewEntity.fit ?? BoxFit.contain,
      placeholderBuilder: hbImageViewEntity.placeholder != null
          ? (BuildContext context) => hbImageViewEntity.placeholder!
          : null,
    );
    return image;
  }

  static Widget _getOtherImageFromNetwork(
      String imageUrl, AcImageViewEntity hbImageViewEntity) {
    var image = Image.network(
      imageUrl,
      width: hbImageViewEntity.width,
      height: hbImageViewEntity.height,
      fit: hbImageViewEntity.fit ?? BoxFit.contain,
      loadingBuilder: hbImageViewEntity.placeholder != null
          ? (BuildContext context, widget, imageChunk) {
              if (imageChunk != null) {
                if (hbImageViewEntity.customLoader != null) {
                  return hbImageViewEntity.customLoader!;
                } else {
                  return Container();
                }
              } else {
                return widget;
              }
            }
          : null,
      errorBuilder: hbImageViewEntity.placeholder != null
          ? (BuildContext context, Object exception, StackTrace? stackTrace) {
              Logger.log(
                  error: exception,
                  stackTrace: stackTrace,
                  logValue: LoggerValue.FIREBASE_CRASHLYTICS);
              return hbImageViewEntity.placeholder!;
            }
          : null,
    );
    return image;
  }

  static getLoader({wrapInArray = false}) {
    Widget loader = Lottie.asset(AcImages.ctaLoader, fit: BoxFit.contain);
    if (wrapInArray) {
      return [loader];
    } else {
      return loader;
    }
  }
}

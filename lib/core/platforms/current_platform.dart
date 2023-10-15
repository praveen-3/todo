import 'dart:io';

import 'package:flutter/foundation.dart';

import '../enums/device_type.dart';

class CurrentPlatform {
  bool get getIsAndroid => Platform.isAndroid;
  bool get getIsIos => Platform.isIOS;
  bool get getIsWeb => kIsWeb;

  DeviceType getDeviceType() {
    if (getIsAndroid) {
      return DeviceType.ANDROID;
    } else if (getIsIos) {
      return DeviceType.IOS;
    } else {
      return DeviceType.WEB;
    }
  }
}

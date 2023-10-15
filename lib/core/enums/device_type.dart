enum DeviceType { ANDROID, IOS, WEB }

extension MethodExtension on DeviceType {
  String get value => ["android_app", "ios_app", "web_app"][index];
}

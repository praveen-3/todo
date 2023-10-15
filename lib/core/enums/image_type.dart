enum ImageType { SVG, JPEG, JPG, PNG }

extension MethodExtension on ImageType {
  String get value => ['svg', 'jpeg', 'jpg', 'png'][index];
}

import 'package:flutter/material.dart';

class AcColors {
  static Color get primary => _getColor('#0A9A07');
  static Color get primaryShade2 => _getColor('#684dae');
  static Color get primaryShade3 => _getColor('#9684c9');
  static Color get primaryShade4 => _getColor('#c5bee4');
  static Color get primaryShade5 => _getColor('#f8f9fa');
  static Color get primaryShade6 => _getColor('#3a1593');
  static Color get backgroundLight => _getColor('#FBFAFF');
  static Color get white => _getColor('#FFFFFF');
  static Color get black => _getColor('#000000');
  static Color get blueBG => _getColor('#f4f6ff');
  static Color get primaryBG => _getColor('#ccbff2');
  static Color get primaryLight => _getColor('#e0ffc7');
  static Color get textGrey => _getColor('#5B5B5B');
  static Color get hintGrey => _getColor('#dea5a5a5');
  static Color get black_87 => _getColor('#1D1D1D');
  static Color get black_12 => _getColor('#000000', transparency: "1F");
  static Color get greyDivider => _getColor('#afafaf');
  static Color get black26 => Colors.black26;
  static Color get lightBlack => _getColor('#99000000');
  static Color get backgroundGrey => _getColor('#f7f8f9');
  static Color get grey => _getColor('#66000000');
  static Color get transparentGrey => _getColor('#42000000');
  static Color get greyShade2 => _getColor('#11111111');
  static Color get greyBlock => _getColor('#f0f0f0');
  static Color get red => _getColor('#f44336');
  static Color get errorRed => _getColor('#ff5148');
  static Color get lightGrey => _getColor('#66000000');
  static Color get transparent => _getColor('00000000');
  static Color get black60 => _getColor('66000000');
  static Color get black40 => _getColor('44000000');
  static Color get black99 => _getColor('99000000');
  static Color get yellow => _getColor('#ffce1a');
  static Color get green => _getColor('#90c73a');
  static Color get lightGreen => _getColor('#2990c73a');
  static Color get blackishGrey => _getColor('#cc707070');
  static Color get darkBlack => _getColor('#de000000');
  static Color get greyShade3 => _getColor("#33a7a7a7");
  static Color get purpleShade => _getColor("#993a1593");
  static Color get purpleShadeBackground => _getColor("#1a3a1593");
  static Color get greyShade4 => _getColor("#a8a8a8");
  static Color get greyShade6 => _getColor("#29a7a7a7");
  static Color get greyShade7 => _getColor("#F5F5F5");
  static Color get black54 => Colors.black54;
  static Color get blackShade1 => _getColor('#323232');
  static Color get greyShade5 => _getColor('#2d000000');
  static Color get disableGrey => _getColor("#26000000");
  static Color get errorBG => _getColor('#29ff5148');
  static Color get blueShade1 => _getColor("#36abe1");
  static Color get black69 => _getColor('#1f0069');
  static Color get purpleLight => _getColor('#e4e8fa');
  static Color get whitePurple => _getColor('#f7f7f7');
  static const Color colorebebeb = Color(0xFFebebeb);
  static const Color colorede7fa = Color(0xFFede7fa);

  static Color _getColor(String colorValue, {String? transparency}) {
    String sanitizedColorString = colorValue.replaceAll("#", "");
    if (transparency != null) {
      return Color(int.parse("0x$transparency$sanitizedColorString"));
    } else {
      return Color(int.parse("0xFF$sanitizedColorString"));
    }
  }

  static Map<String, Color> colorMap = {
    "primary": primary,
    "backgroundLight": backgroundLight,
    "white": white,
    "black": black,
    "blueBG": blueBG,
    "primaryLight": primaryLight,
    "textGrey": textGrey,
    "hintGrey": hintGrey,
    "black_87": black_87,
    "greyDivider": greyDivider,
    "black26": black26,
    "lightBlack": lightBlack,
    "backgroundGrey": backgroundGrey,
    "red": red,
    "yellow": yellow,
    "errorRed": errorRed,
    "green": green,
    "lightGrey": lightGrey,
    "transparent": transparent,
    "black60": black60,
    "primaryShade2": primaryShade2,
    "primaryShade3": primaryShade3,
    "primaryShade4": primaryShade4,
    "greyShade2": greyShade2,
    "lightGreen": lightGreen,
    "primaryShade5": primaryShade5,
    "blackishGrey": blackishGrey,
    "darkBlack": darkBlack,
    "greyShade3": greyShade3,
    "greyBlock": greyBlock,
    "black54": black54,
    "transparentGrey": transparentGrey,
    "greyShade4": greyShade4,
    "disableGrey": disableGrey,
    "greyShade5": greyShade5,
    "greyShade6": greyShade6,
    "purpleShadeBackground": purpleShadeBackground,
    "purpleShade": purpleShade,
    "greyShade7": greyShade7,
    "blackShade1": blackShade1,
    "primaryBG": primaryBG,
    "blueShade1": blueShade1,
  };

  static Color getColorFromString(String? inputColor) {
    Color? color = (inputColor != null) ? colorMap[inputColor] : null;

    if (color == null) {
      return black;
    } else {
      return color;
    }
  }
}

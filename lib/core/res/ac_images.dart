import '../constants/application_constants.dart';

class AcImages {
  static const String cancelButton = 'ic_cancel.svg';
  static const String icBackArrow = 'ic_back_arrow.svg';
  static const String passwordUnhide = "ic_unhide.svg";
  static const String passwordHide = "ic_hide.svg";
  static const String clearText = "ic_cancel_edit_text.svg";
  static const String icEmptyImage = 'empty.svg';
  static const String icSearch = 'ic_search.svg';
  static const String cancelButtonLightGrey = 'ic_cancel_light_grey.svg';
  static const String cancelButtonGrey = 'ic_cancel_grey.svg';

  static const String icErrorSomethingWentWrong =
      'ic_error_something_went_wrong.svg';

  static final String icHamburger = _getLocation('hamburger.svg');
  static final String icAccentBackButton =
      _getLocation('accent_back_button.svg');
  static final String backButton = _getLocation('back_button.png');

  static const String splashError = "splash_error.svg";
  static final String splashRepeatGif = _getLocation("splash_repeat.json");
  static final String splashGif = _getLocation("splash.json");
  static final String ctaLoader = _getLocation("cta.json");
  static final String icNext = _getLocation('ic_next.png');

  static String _getLocation(String name) {
    return ApplicationConstants.IMAGES_DIR_LOCATION + name;
  }
}

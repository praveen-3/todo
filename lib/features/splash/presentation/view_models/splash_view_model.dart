import 'package:todo_flutter/core/utils/app_utils.dart';

import '../../../../core/errors/cache_failure.dart';
import '../../../../core/parents/usecase.dart';
import '../../../../core/platforms/current_platform.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/check_first_launch.dart';
import '../../domain/usecases/check_login.dart';
import '../view_states/login_error.dart';
import 'user_details_view_model.dart';

class SplashViewModel extends UserDetailsViewModel {
  final CheckLogin checkLogin;
  final CheckFirstLaunch checkFirstLaunch;
  final CurrentPlatform currentPlatform;
  String launchUrl = "";
  ViewLoadingState viewState = Loading();

  SplashViewModel(
      {required this.checkLogin,
      required this.checkFirstLaunch,
      required this.currentPlatform})
      : super(
          globalDataProvider: inject(),
        );

  checkForAutoLogin() async {
    if (currentPlatform.getIsIos) {
      await checkFirstLaunch(NoParams());
    }
    var result = await checkLogin(NoParams());
    await result.fold((failure) {
      if (failure is CacheFailure) {
        if (failure is CacheExceptionFailure) {
          AppUtils.showToast("Cache EXception");
        }
        setLoadingState(LoginError(""));
      } else {
        AppUtils.showToast("general error");
        setLoadingState(Error(Strings.GENERAL_ERROR_MESSAGE));
      }
    }, (isLoggedIn) async {
      if (isLoggedIn) {
        await getUser();
      } else {
        setLoadingState(Error(Strings.GENERAL_ERROR_MESSAGE));
      }
    });
  }
}

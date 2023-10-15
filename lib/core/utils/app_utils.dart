import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_flutter/core/errors/cache_failure.dart';

import '../../injection_container.dart';
import '../errors/network_failure.dart';
import '../global_datasource/domain/providers/global_data_provider_contract.dart';
import '../logger/enum/logger_value.dart';
import '../logger/logger.dart';
import '../parents/usecase.dart';
import '../res/ac_colors.dart';
import '../res/dimens.dart';
import '../res/strings.dart';
import '../router/route_constants.dart';
import '../router/route_manager.dart';
import 'check_login.dart';

typedef RebuildCallback = Future<dynamic> Function();

class AppUtils {
  static void logout(bool isAuthorised) async {
    final result =
        await inject<GlobalDataProviderContract>().logout(isAuthorised);
    if (!isAuthorised) {
      await signout();
    } else {
      await result.fold((failure) {
        if (failure is NetworkFailure) {
          showToast(failure.message);
        } else if (failure is CacheFailure) {
          showToast(failure.message);
        } else {
          showToast(Strings.GENERAL_ERROR_MESSAGE);
        }
      }, (logout) async {
        await signout();
      });
    }
  }

  static Future<void> signout() async {
    inject.resetLazySingleton<GlobalDataProviderContract>();
    RouteManager.navigateFromRouteString(RouteConstants.login,
        resetStack: true);
  }

  static popScreen<T>(BuildContext context,
      {T? data, bool isBackPressedOnce = false}) {
    try {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(data);
      } else {
        if (isBackPressedOnce) {
          AppUtils.showToast(Strings.PRESS_BACK_TO_EXIT);
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop(animated: true);
        }
      }
    } catch (e, s) {
      Logger.log(
          error: e, stackTrace: s, logValue: LoggerValue.FIREBASE_CRASHLYTICS);
    }
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AcColors.blackShade1,
        textColor: AcColors.white,
        fontSize: Dimens.dimen_16);
  }

  static executeAfterRebuild(RebuildCallback rebuildCallback) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await rebuildCallback());
  }

  static Future<bool> isLoggedIn() async {
    bool isLoggedIn = false;
    CheckLogin checkLogin = inject<CheckLogin>();
    var result = await checkLogin(NoParams());
    result.fold((failure) => {isLoggedIn = false}, (loginStatus) {
      isLoggedIn = loginStatus;
    });
    return isLoggedIn;
  }

  static unfocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/core/utils/app_utils.dart';
import 'package:todo_flutter/features/auth/presentation/change_notifier_properties/singup_change_notifier_properties.dart';
import 'package:todo_flutter/features/auth/presentation/view_models/signup_viewmodel.dart';
import 'package:todo_flutter/features/auth/presentation/views/signup_view.dart';
import 'package:todo_flutter/features/dashboard/presentation/change_notifier_properties/dashboard_change_notifier_properties.dart';
import 'package:todo_flutter/features/dashboard/presentation/view_models/dashboard_viewmodel.dart';
import 'package:todo_flutter/features/dashboard/presentation/views/dashboard_view.dart';

import '../../features/auth/presentation/change_notifier_properties/login_notitifer_properties.dart';
import '../../features/auth/presentation/view_models/login_viewmodel.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/splash/presentation/view_models/splash_view_model.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../injection_container.dart';
import '../extensions/string_extention.dart';
import '../parents/parent_property_notifier_view_model.dart';
import 'route_constants.dart';

class RouteManager {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const routeKey = "todo_route";

  static FluroRouter router = FluroRouter();

  static final Set<String> authGuardedRoutes = {
    RouteConstants.dashBoard,
  };

  static final Set<String> freeRoutes = {
    RouteConstants.splashRoute,
    RouteConstants.login,
    RouteConstants.signUp,
  };

  static final Handler _splashHandler =
      _getRouteHandler<SplashViewModel>(SplashView());

  static final Handler _loginHandler =
      _getPropertyRouteHanler<LoginViewModel, LoginProperties>(
          const LoginView());

  static final Handler _signUpHandler =
      _getPropertyRouteHanler<SignUpViewModel, SignUpProperties>(
          const SignUpView());

  static final Handler _dashBoardHandler =
      _getPropertyRouteHanler<DashboardViewModel, DashboardProperties>(
          const DashboardView());

  static void setupRouter() {
    router.define(
      RouteConstants.splashRoute,
      handler: _splashHandler,
    );

    router.define(
      RouteConstants.login,
      handler: _loginHandler,
    );

    router.define(
      RouteConstants.signUp,
      handler: _signUpHandler,
    );

    router.define(
      RouteConstants.dashBoard,
      handler: _dashBoardHandler,
    );
  }

  static Handler _getRouteHandler<T extends ChangeNotifier>(Widget view) {
    return Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            ChangeNotifierProvider<T>(
              create: (_) => inject<T>(),
              child: view,
            ));
  }

  static Handler _getPropertyRouteHanler<T extends PropertyChangeNotifier<U>,
      U extends ParentProperties>(Widget view) {
    return Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
            PropertyChangeProvider<T, U>(
              value: inject<T>(),
              child: view,
            ));
  }

  static Future<T?> navigateFromRouteString<T>(String route,
      {bool resetStack = false}) async {
    dynamic matcher = RouteManager.router.match(route);
    if (matcher != null) {
      var uri = Uri.parse(route);
      Map<String, dynamic> data = _getParsedParameters(uri.queryParameters);
      data[RouteManager.routeKey] = uri.path;
      return await _navigateFromPayloadData<T>(data, resetStack: resetStack);
    }
    return null;
  }

  static Future<T?> _navigateFromPayloadData<T>(Map<String, dynamic> payload,
      {bool resetStack = false}) async {
    String? route = payload.remove(routeKey);

    if (route != null) {
      final isLoggedIn = await AppUtils.isLoggedIn();
      final availableRoutes = isLoggedIn ? authGuardedRoutes : freeRoutes;
      availableRoutes.addAll(freeRoutes);

      if (availableRoutes.contains(route)) {
        return await _navigateAndResetStack<T>(route, isLoggedIn,
            resetStack: resetStack);
      }
    }
    return null;
  }

  static Future<T?> _navigateAndResetStack<T>(String routeName, bool isLoggedIn,
      {bool resetStack = false}) async {
    if (!resetStack) {
      final result = await navigatorKey.currentState?.pushNamed(routeName);
      if (result is T) {
        return result;
      }
    } else {
      if (isLoggedIn) {
        navigatorKey.currentState?.pushNamed(routeName);
      } else {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RouteConstants.login, (_) => false);
        if (RouteConstants.login != routeName) {
          navigatorKey.currentState?.pushNamed(routeName);
        }
      }
    }
    return null;
  }

  static Map<String, dynamic> _getParsedParameters(Map<String, String> params) {
    Map<String, dynamic> parsedData = {};
    params.forEach((k, v) {
      parsedData[k] = v.returnCastedPrimitiveType();
    });
    return parsedData;
  }

  static bool checkValidRoute(String route) {
    bool valid = false;
    dynamic matcher = RouteManager.router.match(route);
    if (matcher != null) {
      valid = true;
    }
    return valid;
  }
}

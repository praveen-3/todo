import 'package:flutter/material.dart';

import 'core/platforms/current_platform.dart';
import 'core/res/ac_theme.dart';
import 'core/router/route_constants.dart';
import 'core/router/route_manager.dart';
import 'core/widgets/behaviour/no_scroll_glow_behaviour.dart';
import 'injection_container.dart';

initializeApplicationConfig() async {
  if (!CurrentPlatform().getIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
  }
  await setupInjection();
  RouteManager.setupRouter();
}

void main() async {
  await initializeApplicationConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: RouteManager.navigatorKey,
        initialRoute: RouteConstants.splashRoute,
        theme: AcTheme.getAppTheme(),
        builder: (BuildContext context, Widget? child) {
          return ScrollConfiguration(
            behavior: NoScrollGlowBehavior(),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            ),
          );
        },
        onGenerateRoute: RouteManager.router.generator);
  }
}

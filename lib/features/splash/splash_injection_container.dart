import 'package:get_it/get_it.dart';

import 'domain/usecases/check_first_launch.dart';
import 'domain/usecases/check_login.dart';
import 'presentation/view_models/splash_view_model.dart';
import 'presentation/views/splash_view.dart';

class SplashInjectionContainer {
  static Future<void> setupInjection() async {
    final inject = GetIt.I;

    //domain
    inject.registerLazySingleton(() => CheckLogin(inject()));
    inject.registerLazySingleton(() => CheckFirstLaunch(inject()));

    //Presentation
    inject.registerFactory(() => SplashView());
    inject.registerFactory(
      () => SplashViewModel(
        checkLogin: inject(),
        checkFirstLaunch: inject(),
        currentPlatform: inject(),
      ),
    );
  }
}

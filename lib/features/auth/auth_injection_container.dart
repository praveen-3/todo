import 'package:get_it/get_it.dart';

import '../../core/states/view_loading_states.dart';
import 'data/datasources/auth_cache_data_source.dart';
import 'data/datasources/auth_cache_data_source_contract.dart';
import 'data/datasources/auth_data_source_contract.dart';
import 'data/datasources/auth_restful_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/auth_repository_contract.dart';
import 'domain/usecases/user_creation_request.dart';
import 'domain/usecases/login.dart';
import 'presentation/change_notifier_properties/singup_change_notifier_properties.dart';
import 'presentation/change_notifier_properties/login_notitifer_properties.dart';
import 'presentation/view_models/signup_viewmodel.dart';
import 'presentation/view_models/login_viewmodel.dart';

class AuthInjectionContainer {
  static Future<void> setupInjection() async {
    final inject = GetIt.I;

    //Data
    inject.registerLazySingleton<AuthDataSourceContract>(
        () => AuthRestfulDataSource(networkManagerContract: inject()));

    inject.registerLazySingleton<AuthCacheDataSourceContract>(
        () => AuthCacheDataSource(inject()));

    inject.registerLazySingleton<AuthRepositoryContract>(() => AuthRepository(
        authDataSourceContract: inject(),
        authCacheDataSourceContract: inject()));

    //Domain
    inject.registerLazySingleton(
        () => UserCreationRequest(authRespositoryContract: inject()));
    inject.registerLazySingleton(() => Login(authRepositoryContract: inject()));

    //Presentation
    inject.registerFactory(
      () => LoginPropertiesContainer(
        LoginProperties(Empty()),
      ),
    );

    inject.registerFactory(() => LoginViewModel(inject(), inject()));

    inject.registerFactory(
      () => SignUpPropertiesContainer(
        SignUpProperties(Empty()),
      ),
    );

    inject.registerFactory(() => SignUpViewModel(inject()));
  }
}

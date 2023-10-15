import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/core/global_datasource/data/datasources/global_restful_data_source.dart';
import 'package:todo_flutter/core/network/interceptors/logging_interceptor.dart';
import 'package:todo_flutter/core/utils/check_login.dart';
import 'package:todo_flutter/features/dashboard/dashboard_injection_container.dart';

import 'core/cache/cache_manager.dart';
import 'core/cache/contracts/cache_manager_contract.dart';
import 'core/cache/datasources/secure_cache.dart';
import 'core/cache/datasources/shared_pref.dart';
import 'core/constants/application_constants.dart';
import 'core/global_datasource/data/datasources/global_cache_data_source.dart';
import 'core/global_datasource/data/datasources/global_cache_data_source_contract.dart';
import 'core/global_datasource/data/datasources/global_data_source_contract.dart';
import 'core/global_datasource/domain/providers/global_data_provider.dart';
import 'core/global_datasource/domain/providers/global_data_provider_contract.dart';
import 'core/network/contracts/network_failure_handler_contract.dart';
import 'core/network/contracts/network_manager_contract.dart';
import 'core/network/implementations/network_failure_handler.dart';
import 'core/network/implementations/network_manager.dart';
import 'core/network/interceptors/auth_interceptor.dart';
import 'core/platforms/current_platform.dart';
import 'core/transition_datasource/data/datasources/view_transition_data_source.dart';
import 'core/transition_datasource/data/datasources/view_transition_data_source_contract.dart';
import 'core/transition_datasource/data/repositories/transition_repository.dart';
import 'core/transition_datasource/domain/repositories/transition_repository_contract.dart';
import 'core/transition_datasource/domain/usecases/get_transition_data.dart';
import 'core/transition_datasource/domain/usecases/set_transition_data.dart';
import 'core/utils/switch_401_manager.dart';
import 'features/auth/auth_injection_container.dart';
import 'features/splash/splash_injection_container.dart';

final inject = GetIt.I;

Future<void> setupInjection() async {
  // Platform check
  inject.registerLazySingleton(() => CurrentPlatform());
  //Cache
  inject.registerLazySingleton(() => const FlutterSecureStorage());
  var sharedPref = await SharedPreferences.getInstance();
  inject.registerLazySingleton(() => sharedPref);

  inject.registerLazySingleton(() => SharedPref(inject()));
  inject.registerLazySingleton(() => SecureCache(inject()));
  inject.registerLazySingleton<CacheManagerContract>(
      () => CacheManager(secureCache: inject(), sharedPref: inject()));

  // Network
  inject.registerLazySingleton(() => BaseOptions(
      receiveTimeout: ApplicationConstants.NETWORK_RECIEVE_TIMEOUT));

  var dio = Dio(inject());
  dio.interceptors.add(AuthInterceptor(inject()));
  dio.interceptors.add(LoggingInterceptor());

  inject.registerLazySingleton(() => dio);
  inject.registerLazySingleton<NetworkFailureHandlerContract>(
      () => NetworkFailureHandler(inject()));
  inject.registerLazySingleton<NetworkManagerContract>(
      () => NetworkManager(dio: inject(), failureHandler: inject()));

  inject.registerLazySingleton<Switch401Manager>(
    () => Switch401Manager(),
  );

  // Global Data Provider
  inject.registerLazySingleton<GlobalDataSourceContract>(
      () => GlobalRestfulDataSource(inject()));
  inject.registerLazySingleton<GlobalCacheDataSourceContract>(
      () => GlobalCacheDataSource(inject()));

  inject.registerLazySingleton<GlobalDataProviderContract>(
      () => GlobalDataProvider(inject(), inject()));

  //core
  inject.registerLazySingleton(() => CheckLogin(inject()));

  // Transition DataSources
  injectTransitionViews();

  // Feature
  AuthInjectionContainer.setupInjection();
  SplashInjectionContainer.setupInjection();
  DashBoardInjectionContainer.setupInjection();
}

void injectTransitionViews() {}

void initTrasitionDataForView<Type, View extends Widget>() {
  inject.registerLazySingleton<ViewTransitionDataSourceContract<View>>(
      () => ViewTransitionDataSource<View>());

  inject.registerFactory<TransitionRepositoryContract<View>>(
      () => TransitionRepository<View>(viewTransitionDataSource: inject()));

  inject.registerFactory<GetTransitionData<Type, View>>(
      () => GetTransitionData<Type, View>(repository: inject()));
  inject.registerFactory<SetTransitionData<Type, View>>(
      () => SetTransitionData<Type, View>(repository: inject()));
}

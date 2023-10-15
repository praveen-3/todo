import 'package:dio/dio.dart';

import '../../cache/cache_keys.dart';
import '../../cache/cache_type.dart';
import '../../cache/contracts/cache_manager_contract.dart';

/// Extends [Interceptor] class
///
/// Used for Intercepting Api Calls for Checking Auth Credentials.
class AuthInterceptor extends Interceptor {
  final CacheManagerContract cacheManager;

  AuthInterceptor(this.cacheManager);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var result = await cacheManager.getDataForKey(CacheKeys.AUTH_TOKEN,
        cacheType: CacheType.SECURE);

    result.fold(
      (failure) => {},
      (authToken) {
        // ignore: prefer_interpolation_to_compose_strings
        options.headers['Authorization'] = 'Bearer ' + authToken;
      },
    );

    super.onRequest(options, handler);
  }
}

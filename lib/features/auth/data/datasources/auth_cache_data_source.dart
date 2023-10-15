import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_keys.dart';
import '../../../../core/cache/cache_type.dart';
import '../../../../core/cache/contracts/cache_manager_contract.dart';
import '../../../../core/errors/failure.dart';
import 'auth_cache_data_source_contract.dart';

class AuthCacheDataSource implements AuthCacheDataSourceContract {
  final CacheManagerContract cacheManager;
  AuthCacheDataSource(this.cacheManager);
  @override
  Future<Either<Failure, void>> setAuthInCache(String authToken) async {
    return await cacheManager.setDataForKey(CacheKeys.AUTH_TOKEN, authToken,
        cacheType: CacheType.SECURE);
  }
}

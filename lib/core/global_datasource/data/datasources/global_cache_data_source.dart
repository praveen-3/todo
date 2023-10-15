import 'package:dartz/dartz.dart';

import '../../../cache/cache_keys.dart';
import '../../../cache/cache_type.dart';
import '../../../cache/contracts/cache_manager_contract.dart';
import '../../../errors/failure.dart';
import '../../../errors/unknown_failure.dart';
import 'global_cache_data_source_contract.dart';

class GlobalCacheDataSource implements GlobalCacheDataSourceContract {
  final CacheManagerContract cacheManagerContract;
  GlobalCacheDataSource(this.cacheManagerContract);
  @override
  Future<Either<Failure, void>> saveFCMToCache(String fcm) {
    return cacheManagerContract.setDataForKey(CacheKeys.FCM_TOKEN, fcm);
  }

  @override
  Future<Either<Failure, void>> clearAllCache() {
    return cacheManagerContract.clearAllCache();
  }

  @override
  Future<Either<Failure, String>> getAuthToken() async {
    Either<Failure, dynamic> result = await cacheManagerContract
        .getDataForKey(CacheKeys.AUTH_TOKEN, cacheType: CacheType.SECURE);

    late Either<Failure, String> finalResult;

    result.fold((failure) {
      finalResult = Left(failure);
    }, (auth) {
      if (auth is String) {
        finalResult = Right(auth);
      } else {
        finalResult = Left(UnknownFailure());
      }
    });
    return finalResult;
  }

  @override
  Future<Either<Failure, String>> getFCM() async {
    Either<Failure, dynamic> result =
        await cacheManagerContract.getDataForKey(CacheKeys.FCM_TOKEN);

    late Either<Failure, String> finalResult;

    result.fold((failure) {
      finalResult = Left(failure);
    }, (auth) {
      if (auth is String) {
        finalResult = Right(auth);
      } else {
        finalResult = Left(UnknownFailure());
      }
    });
    return finalResult;
  }
}

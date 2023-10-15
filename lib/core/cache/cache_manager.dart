import 'package:dartz/dartz.dart';

import '../errors/cache_failure.dart';
import '../errors/failure.dart';
import 'cache_type.dart';
import 'contracts/cache_manager_contract.dart';
import 'contracts/cache_storage_contract.dart';
import 'datasources/secure_cache.dart';
import 'datasources/shared_pref.dart';

/// Uses [SecureCache] and [SharedPref] for Cache
///
/// Use [CacheType] for Type of Cache you want to use.
class CacheManager implements CacheManagerContract {
  final SecureCache secureCache;
  final SharedPref sharedPref;

  Map<CacheType, CacheStorageContract>? _cacheMap;

  CacheManager({
    required this.secureCache,
    required this.sharedPref,
  }) {
    _cacheMap = {
      CacheType.SECURE: secureCache,
      CacheType.SHARED_PREF: sharedPref
    };
  }

  @override
  Future<Either<Failure, dynamic>> getDataForKey(String key,
      {CacheType cacheType = CacheType.SHARED_PREF}) async {
    try {
      var value = await _cacheMap![cacheType]!.getDataForKey(key);
      return Right(value);
      // ignore: nullable_type_in_catch_clause
    } on CacheFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> setDataForKey(String key, data,
      {CacheType cacheType = CacheType.SHARED_PREF}) async {
    try {
      await _cacheMap![cacheType]!.setDataForKey(key, data);
      return const Right(null);
    } on CacheFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> removeDataForKey(String key,
      {CacheType cacheType = CacheType.SHARED_PREF}) async {
    try {
      await _cacheMap![cacheType]!.removeDataForKey(key);
      return const Right(null);
    } on CacheFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> clearCache(
      {CacheType cacheType = CacheType.SHARED_PREF}) async {
    try {
      await _cacheMap![cacheType]!.clearCache();
      return const Right(null);
    } on CacheFailure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> clearAllCache(
      {List<CacheType> cacheTypes = CacheType.values}) async {
    Either<Failure, void> finalResult = const Right(null);
    for (var cacheType in cacheTypes) {
      var result = await clearCache(cacheType: cacheType);
      result.fold(
        (failure) {
          finalResult = Left(failure);
        },
        (r) => {},
      );
      if (finalResult.isLeft()) {
        break;
      }
    }
    return finalResult;
  }
}

import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../cache_type.dart';
import '../datasources/shared_pref.dart';

abstract class CacheManagerContract {
  /// Get Data from the Cache for Given [key]
  ///
  /// Return [Either] of [Failure] or [dynamic]
  ///
  /// Default Cache Type - [SharedPref]
  ///
  /// Params -
  /// * [key] cache key
  /// * [CacheType] {Optional} for type of Cache
  Future<Either<Failure, dynamic>> getDataForKey(String key,
      {CacheType cacheType});

  /// Set [data] from the Cache for Given [key] for Cache Type - [CacheType]
  ///
  /// Default Cache Type - [SharedPref]
  ///
  /// Return [Either] of [Failure] or [void]
  ///
  /// Params -
  /// * [key] cache key
  /// * [data] data for [key]
  /// * [CacheType] {Optional} for type of Cache
  Future<Either<Failure, void>> setDataForKey(String key, dynamic data,
      {CacheType cacheType});

  /// Remove Data for given [key] for Cache Type - [CacheType]
  ///
  /// Default Cache Type - [SharedPref]
  ///
  /// Return [Either] of [Failure] or [void]
  ///
  /// Params -
  /// * [key] cache key
  /// * [CacheType] {Optional} for type of Cache
  Future<Either<Failure, void>> removeDataForKey(String key,
      {CacheType cacheType});

  /// Clear All Cache of Cache Type - [CacheType]
  ///
  /// Default Cache Type - [SharedPref]
  ///
  /// Return [Either] of [Failure] or [void]
  Future<Either<Failure, void>> clearCache({CacheType cacheType});

  /// Clear All Cache of Cache Type - [CacheType]
  ///
  /// Default - List<CacheType> CacheType.values
  ///
  /// Return [Either] of [Failure] or [void]
  Future<Either<Failure, void>> clearAllCache({List<CacheType> cacheTypes});
}

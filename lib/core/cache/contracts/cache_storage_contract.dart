abstract class CacheStorageContract {
  /// Return [Future] of value of [key] in Cache
  ///
  /// Throws [CacheFailure] if Key was not found in Cache or for any internal exception
  ///
  /// Params -
  /// [key] cache key
  ///
  /// Using this function directly is not Recommended Use Wrapper Class [CacheManager] instead.
  Future<dynamic> getDataForKey(String key);

  /// Set [data] for [key] in Cache
  ///
  /// Throws [CacheFailure] for any other internal exception
  ///
  /// Params -
  /// * [key] cache key
  /// * [data] data for given [key] that should be stored in cache
  ///
  /// Using this function directly is not Recommended Use Wrapper Class [CacheManager] instead.
  setDataForKey(String key, dynamic data);

  /// Remove Data for [key] in Cache
  ///
  /// Throws [CacheFailure] for any other internal exception
  ///
  /// Params -
  /// [key] cache key
  ///
  /// Using this function directly is not Recommended Use Wrapper Class [CacheManager] instead.
  removeDataForKey(String key);

  /// Clear Data
  ///
  /// Throws [CacheFailure] for any other internal exception
  ///
  /// Using this function directly is not Recommended Use Wrapper Class [CacheManager] instead.
  clearCache();
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../errors/cache_failure.dart';
import '../../logger/enum/logger_value.dart';
import '../../logger/logger.dart';
import '../../res/strings.dart';
import '../contracts/cache_storage_contract.dart';

/// Uses [FlutterSecureStorage] for Secure Storage of Cache
///
/// Using this Class Directly is not Recommended Use Wrapper Class [CacheManager] instead.
class SecureCache implements CacheStorageContract {
  static FlutterSecureStorage? _cacheInstance;

  SecureCache(FlutterSecureStorage flutterSecureStorage) {
    _cacheInstance = flutterSecureStorage;
  }

  @override
  Future<String> getDataForKey(String key) async {
    try {
      final result = await _cacheInstance!.read(key: key);
      if (result != null) {
        return Future.value(result);
      } else {
        throw const CacheFailure(message: Strings.KEY_NOT_FOUND);
      }
    } catch (e, s) {
      Logger.log(
          error: e, stackTrace: s, logValue: LoggerValue.FIREBASE_CRASHLYTICS);
      if (e is CacheFailure) {
        rethrow;
      }
      throw const CacheExceptionFailure(Strings.SECURE_CACHE_FAILURE);
    }
  }

  @override
  setDataForKey(String key, dynamic data) async {
    try {
      await _cacheInstance!.write(key: key, value: data);
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SECURE_CACHE_FAILURE);
    }
  }

  @override
  removeDataForKey(String key) async {
    try {
      await _cacheInstance!.delete(key: key);
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SECURE_CACHE_FAILURE);
    }
  }

  @override
  clearCache() async {
    try {
      await _cacheInstance!.deleteAll();
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SECURE_CACHE_FAILURE);
    }
  }
}

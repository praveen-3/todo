import 'package:shared_preferences/shared_preferences.dart';

import '../../errors/cache_failure.dart';
import '../../res/strings.dart';
import '../contracts/cache_storage_contract.dart';

/// Uses [SharedPreferences] for Cache
///
/// Using this Class Directly is not Recommended Use Wrapper Class [CacheManager] instead.
class SharedPref implements CacheStorageContract {
  static SharedPreferences? _cacheInstance;

  SharedPref(SharedPreferences sharedPreferences) {
    _cacheInstance = sharedPreferences;
  }

  @override
  Future<dynamic> getDataForKey(String key) {
    try {
      final result = _cacheInstance!.get(key);
      if (result != null) {
        return Future.value(result);
      } else {
        throw const CacheFailure(message: Strings.KEY_NOT_FOUND);
      }
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SHARED_PREF_FAILURE);
    }
  }

  @override
  setDataForKey(String key, dynamic data) async {
    try {
      if (data is int) {
        await _cacheInstance!.setInt(key, data);
      } else if (data is bool) {
        await _cacheInstance!.setBool(key, data);
      } else if (data is double) {
        await _cacheInstance!.setDouble(key, data);
      } else if (data is List<String>) {
        await _cacheInstance!.setStringList(key, data);
      } else if (data is String) {
        await _cacheInstance!.setString(key, data);
      }
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SHARED_PREF_FAILURE);
    }
  }

  @override
  removeDataForKey(String key) async {
    try {
      await _cacheInstance!.remove(key);
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SHARED_PREF_FAILURE);
    }
  }

  @override
  clearCache() async {
    try {
      await _cacheInstance!.clear();
    } catch (e) {
      throw const CacheExceptionFailure(Strings.SHARED_PREF_FAILURE);
    }
  }
}

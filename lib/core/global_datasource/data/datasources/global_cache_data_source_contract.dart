import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';

abstract class GlobalCacheDataSourceContract {
  Future<Either<Failure, void>> saveFCMToCache(String fcm);
  Future<Either<Failure, void>> clearAllCache();
  Future<Either<Failure, String>> getFCM();
  Future<Either<Failure, String>> getAuthToken();
}

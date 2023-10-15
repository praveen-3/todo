import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthCacheDataSourceContract {
  /// Saves AuthToken in [CacheKeys.AUTH_TOKEN] key
  ///
  /// Return [Either] [Failure] or [void]
  Future<Either<Failure, void>> setAuthInCache(String authToken);
}

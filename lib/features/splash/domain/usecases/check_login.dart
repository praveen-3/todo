import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_keys.dart';
import '../../../../core/cache/cache_type.dart';
import '../../../../core/cache/contracts/cache_manager_contract.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';

class CheckLogin implements UseCase<bool, NoParams> {
  final CacheManagerContract cacheManager;
  CheckLogin(this.cacheManager);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    var result = await cacheManager.getDataForKey(CacheKeys.AUTH_TOKEN,
        cacheType: CacheType.SECURE);

    late Either<Failure, bool> finalResult;

    result.fold((failure) => {finalResult = Left(failure)}, (authToken) {
      if (authToken != null && (authToken as String).isEmpty) {
        finalResult = Right(false);
      } else {
        finalResult = Right(true);
      }
    });
    return finalResult;
  }
}

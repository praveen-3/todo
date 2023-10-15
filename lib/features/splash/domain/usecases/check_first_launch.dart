import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_keys.dart';
import '../../../../core/cache/cache_type.dart';
import '../../../../core/cache/contracts/cache_manager_contract.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';

class CheckFirstLaunch implements UseCase<void, NoParams> {
  final CacheManagerContract cacheManager;
  CheckFirstLaunch(this.cacheManager);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    var result = await cacheManager.getDataForKey(CacheKeys.HAS_RUN_BEFORE,
        cacheType: CacheType.SHARED_PREF);

    late Either<Failure, bool> finalResult;

    await result.fold(
      (failure) async {
        await cacheManager.clearCache(cacheType: CacheType.SECURE);
        await cacheManager.setDataForKey(CacheKeys.HAS_RUN_BEFORE, true);
        finalResult = Left(failure);
      },
      (hasRunBefore) async {
        if (hasRunBefore == true) {
          finalResult = Right(true);
        } else {
          finalResult = Right(false);
          await cacheManager.clearCache(cacheType: CacheType.SECURE);
          await cacheManager.setDataForKey(CacheKeys.HAS_RUN_BEFORE, true);
        }
      },
    );
    return finalResult;
  }
}

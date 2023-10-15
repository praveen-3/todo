import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../data/datasources/global_cache_data_source_contract.dart';
import '../../data/datasources/global_data_source_contract.dart';
import '../entities/logout_entity.dart';
import '../entities/user_data_entity.dart';
import '../params/get_user_params.dart';
import 'global_data_provider_contract.dart';

class GlobalDataProvider implements GlobalDataProviderContract {
  final GlobalDataSourceContract dataSourceContract;
  UserDataEntity? userDataEntity;
  final GlobalCacheDataSourceContract cacheDataSourceContract;

  GlobalDataProvider(this.dataSourceContract, this.cacheDataSourceContract);
  Future<Either<Failure, UserDataEntity>> getUser(
      GetUserParams getUserParams) async {
    late Either<Failure, UserDataEntity> finalResult;
    if (userDataEntity != null &&
        !getUserParams.getUpdatedUser &&
        getUserParams.id == null) {
      finalResult = Right(this.userDataEntity!);
    } else {
      var result = await dataSourceContract.getUser(getUserParams);
      result.fold((failure) => {finalResult = Left(failure)},
          (userDataEntityResponse) {
        if (getUserParams.id == null) {
          userDataEntity = userDataEntityResponse;
        }
        finalResult = Right(userDataEntityResponse);
      });
    }
    return finalResult;
  }

  Future<Either<Failure, LogoutEntity>> clearCache(
      LogoutEntity logoutEntity) async {
    late Either<Failure, LogoutEntity> finalResult;
    var clearAllCacheResult = await cacheDataSourceContract.clearAllCache();
    await clearAllCacheResult.fold(
        (cacheFailure) => {finalResult = Left(cacheFailure)},
        (r) => {finalResult = Right(logoutEntity)});
    return finalResult;
  }

  @override
  Future<Either<Failure, LogoutEntity>> logout(bool isAuthorised) async {
    late Either<Failure, LogoutEntity> finalResult;
    LogoutEntity logoutEntity = LogoutEntity();
    if (!isAuthorised) {
      finalResult = await clearCache(logoutEntity);
    } else {
      var result = await dataSourceContract.logout();
      await result.fold((failure) => {finalResult = Left(failure)},
          (logoutResponse) async {
        finalResult = await clearCache(logoutResponse);
      });
    }
    return finalResult;
  }

  @override
  void resetUserData() {
    userDataEntity = null;
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_creation_request_entity.dart';
import '../../domain/entities/login_entitiy.dart';
import '../../domain/repositories/auth_repository_contract.dart';
import '../../domain/usecases/user_creation_request.dart';
import '../../domain/usecases/login.dart';
import '../datasources/auth_cache_data_source_contract.dart';
import '../datasources/auth_data_source_contract.dart';

class AuthRepository implements AuthRepositoryContract {
  AuthDataSourceContract authDataSourceContract;
  AuthCacheDataSourceContract authCacheDataSourceContract;

  AuthRepository(
      {required this.authDataSourceContract,
      required this.authCacheDataSourceContract});

  @override
  Future<Either<Failure, UserCreationRequestEntity>> sendOtp(
      UserCreationRequestParams loginWithOtpParams) async {
    return await authDataSourceContract.userCreationRequest(loginWithOtpParams);
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
      LoginParams validateOtpParams) async {
    var result = await authDataSourceContract.login(validateOtpParams);
    late Either<Failure, LoginEntity> finalResult;

    String accessToken = "";
    result.fold((failure) => {finalResult = Left(failure)},
        (validateOtpEntity) async {
      accessToken = validateOtpEntity.access_token ?? "";
      finalResult = Right(validateOtpEntity);
    });
    if (accessToken.isNotEmpty) {
      await authCacheDataSourceContract.setAuthInCache(accessToken);
    }

    return finalResult;
  }
}

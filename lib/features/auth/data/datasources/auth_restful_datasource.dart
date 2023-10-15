import 'package:dartz/dartz.dart';
import 'package:todo_flutter/core/constants/url_constants.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/contracts/network_manager_contract.dart';
import '../../../../core/network/enums/request_method.dart';
import '../../../../core/network/models/network_response.dart';
import '../../domain/entities/user_creation_request_entity.dart';
import '../../domain/entities/login_entitiy.dart';
import '../../domain/usecases/user_creation_request.dart';
import '../../domain/usecases/login.dart';
import '../models/user_creation_request_restful_model.dart';
import '../models/login_restful_model.dart';
import 'auth_data_source_contract.dart';

class AuthRestfulDataSource implements AuthDataSourceContract {
  final NetworkManagerContract networkManagerContract;

  AuthRestfulDataSource({required this.networkManagerContract});

  @override
  Future<Either<Failure, UserCreationRequestEntity>> userCreationRequest(
      UserCreationRequestParams loginWithOtpParams) async {
    final Map<String, dynamic> data = {};
    data["email"] = loginWithOtpParams.email;
    data["user_name"] = loginWithOtpParams.userName;
    data["password"] = loginWithOtpParams.password;

    Either<Failure, NetworkResponse> result = await networkManagerContract
        .request(UrlConstants.CREATE_USER, RequestMethod.POST, data: data);

    late Either<Failure, UserCreationRequestEntity> finalResult;

    result.fold((failure) => {finalResult = Left(failure)}, (sendOtpResponse) {
      var map = Map<String, dynamic>.from(sendOtpResponse.response.data);
      UserCreationRequestEntity loginWithOtpEntity =
          UserCreationRequestRestfulModel.fromJson(map);
      finalResult = Right(loginWithOtpEntity);
    });
    return finalResult;
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
      LoginParams validateOtpParams) async {
    final Map<String, dynamic> data = {};
    data["grant_type"] = validateOtpParams.grantType;
    data["username"] = validateOtpParams.username;
    data["password"] = validateOtpParams.password;
    Either<Failure, NetworkResponse> result = await networkManagerContract
        .request(UrlConstants.LOGIN, RequestMethod.POST, data: data);

    late Either<Failure, LoginEntity> finalResult;

    result.fold((faliure) => {finalResult = Left(faliure)},
        (validateOtpResponse) {
      var map = Map<String, dynamic>.from(validateOtpResponse.response.data);
      LoginEntity validateOtpEntity = LoginRestfulModel.fromJson(map);
      finalResult = Right(validateOtpEntity);
    });

    return finalResult;
  }
}

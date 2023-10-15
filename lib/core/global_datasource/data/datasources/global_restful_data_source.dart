import 'package:dartz/dartz.dart';

import '../../../constants/url_constants.dart';

import '../../../errors/failure.dart';
import '../../../network/contracts/network_manager_contract.dart';
import '../../../network/enums/request_method.dart';
import '../../../network/models/network_response.dart';
import '../../domain/entities/logout_entity.dart';
import '../../domain/entities/user_data_entity.dart';
import '../../domain/params/get_user_params.dart';
import '../models/restful_models/logout_restful_model.dart';
import '../models/restful_models/user_data_restful_model.dart';
import 'global_data_source_contract.dart';

class GlobalRestfulDataSource extends GlobalDataSourceContract {
  final NetworkManagerContract networkManager;
  GlobalRestfulDataSource(this.networkManager);
  @override
  Future<Either<Failure, UserDataEntity>> getUser(
      GetUserParams getUserParams) async {
    String url = UrlConstants.GET_USER;
    if (getUserParams.id != null) {
      url += "/${getUserParams.id}";
    }

    Either<Failure, NetworkResponse> result =
        await networkManager.request(url, RequestMethod.GET);

    late Either<Failure, UserDataEntity> finalResult;
    result.fold((failure) => {finalResult = Left(failure)}, (userData) {
      var map = Map<String, dynamic>.from(userData.response.data);
      UserDataEntity userEntity = UserDataRestfulModel.fromJson(map);
      finalResult = Right(userEntity);
    });

    return finalResult;
  }

  @override
  Future<Either<Failure, LogoutEntity>> logout() async {
    Either<Failure, NetworkResponse> result =
        await networkManager.request(UrlConstants.LOGOUT, RequestMethod.GET);

    late Either<Failure, LogoutEntity> finalResult;
    result.fold((failure) => {finalResult = Left(failure)}, (logoutResponse) {
      var map = Map<String, dynamic>.from(logoutResponse.response.data);
      LogoutEntity logoutEntity = LogoutRestfulModel.fromJson(map);
      finalResult = Right(logoutEntity);
    });

    return finalResult;
  }
}

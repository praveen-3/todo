import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../entities/logout_entity.dart';
import '../entities/user_data_entity.dart';
import '../params/get_user_params.dart';

abstract class GlobalDataProviderContract {
  Future<Either<Failure, UserDataEntity>> getUser(GetUserParams getUserParams);

  Future<Either<Failure, LogoutEntity>> logout(bool isAuthorised);

  void resetUserData();
}

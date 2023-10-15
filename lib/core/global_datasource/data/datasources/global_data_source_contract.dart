import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../domain/entities/logout_entity.dart';
import '../../domain/entities/user_data_entity.dart';
import '../../domain/params/get_user_params.dart';

abstract class GlobalDataSourceContract {
  /// Return [Either] [Failure] or [UserDataEntity]
  Future<Either<Failure, UserDataEntity>> getUser(GetUserParams getUserParams);

  Future<Either<Failure, LogoutEntity>> logout();
}

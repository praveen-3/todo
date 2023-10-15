import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_creation_request_entity.dart';
import '../../domain/entities/login_entitiy.dart';
import '../../domain/usecases/user_creation_request.dart';
import '../../domain/usecases/login.dart';

abstract class AuthDataSourceContract {
  /// Return [Future] of [Either] [Failure] or [UserCreationRequestEntity]
  Future<Either<Failure, UserCreationRequestEntity>> userCreationRequest(
      UserCreationRequestParams loginWithOtpParams);

  /// Return [Future] of [Either] [Failure] or [UserCreationRequestEntity]
  Future<Either<Failure, LoginEntity>> login(LoginParams validateOtpParams);
}

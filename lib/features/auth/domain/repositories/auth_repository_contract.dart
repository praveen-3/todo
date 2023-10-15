import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_creation_request_entity.dart';
import '../entities/login_entitiy.dart';
import '../usecases/user_creation_request.dart';
import '../usecases/login.dart';

abstract class AuthRepositoryContract {
  /// Return [Future] of [Either] [Failure] or [UserCreationRequestEntity]
  Future<Either<Failure, UserCreationRequestEntity>> sendOtp(
      UserCreationRequestParams loginWithOtpParams);

  /// Return [Future] of [Either] [Failure] or [UserCreationRequestEntity]
  Future<Either<Failure, LoginEntity>> login(LoginParams validateOtpParams);
}

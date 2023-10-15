import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';
import '../entities/user_creation_request_entity.dart';
import '../repositories/auth_repository_contract.dart';

class UserCreationRequest
    implements UseCase<UserCreationRequestEntity, UserCreationRequestParams> {
  final AuthRepositoryContract authRespositoryContract;

  UserCreationRequest({required this.authRespositoryContract});
  @override
  Future<Either<Failure, UserCreationRequestEntity>> call(
      UserCreationRequestParams userCreationRequestParams) async {
    return await authRespositoryContract.sendOtp(userCreationRequestParams);
  }
}

class UserCreationRequestParams extends Equatable {
  final String email;
  final String userName;
  final String password;

  const UserCreationRequestParams({
    required this.email,
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [email, userName, password];
}

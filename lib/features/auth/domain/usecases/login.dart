import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';
import '../entities/login_entitiy.dart';
import '../repositories/auth_repository_contract.dart';

class Login implements UseCase<LoginEntity, LoginParams> {
  final AuthRepositoryContract authRepositoryContract;
  Login({required this.authRepositoryContract});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await authRepositoryContract.login(params);
  }
}

class LoginParams extends Equatable {
  final String grantType = "password";
  final String username;
  final String password;

  const LoginParams(this.username, this.password);

  @override
  List<Object?> get props => [
        grantType,
        username,
        password,
      ];
}

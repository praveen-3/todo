import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/features/auth/presentation/change_notifier_properties/login_notitifer_properties.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/network_failure.dart';
import '../../../../core/global_datasource/domain/params/get_user_params.dart';
import '../../../../core/global_datasource/domain/providers/global_data_provider_contract.dart';
import '../../../../core/network/enums/response_status.dart';
import '../../../../core/parents/parent_property_notifier_view_model.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../domain/entities/user_creation_request_entity.dart';
import '../../domain/entities/login_entitiy.dart';
import '../../domain/usecases/login.dart';
import '../view_states/login_success.dart';

class LoginViewModel extends ParentPropertyNotifierViewModel<
    LoginPropertiesContainer, LoginProperties, void> {
  final Login login;
  final GlobalDataProviderContract globalDataProviderContract;
  LoginEntity? validateOtpEntity;
  UserCreationRequestEntity? loginWithOtpEntity;
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  LoginViewModel(this.login, this.globalDataProviderContract);

  getAccessToken() async {
    Either<Failure, LoginEntity> result = await login.call(
      LoginParams(userNameTextController.text, passwordTextController.text),
    );

    await result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          if (failure.status != ResponseStatus.UNAUTHORIZED.value) {
            propertiesConainter.view_notifier.propertyValue =
                Error(failure.message);
            setLoadingState(propertiesConainter.view_notifier);
          }
        } else {
          propertiesConainter.view_notifier.propertyValue =
              Error(Strings.GENERAL_ERROR_MESSAGE);
          setLoadingState(propertiesConainter.view_notifier);
        }
      },
      (response) async {
        validateOtpEntity = response;
        await getUser();
      },
    );
  }

  getUser() async {
    final result = await globalDataProviderContract
        .getUser(GetUserParams(getUpdatedUser: true));
    await result.fold((userFailure) {
      String failureMsg;
      if (userFailure is NetworkFailure) {
        failureMsg = userFailure.message;
        if (userFailure.status == ResponseStatus.UNAUTHORIZED.value) {
          return;
        }
      } else {
        failureMsg = Strings.GENERAL_ERROR_MESSAGE;
      }
      propertiesConainter.view_notifier.propertyValue = Error(failureMsg);
      setLoadingState(propertiesConainter.view_notifier);
    }, (userResponse) async {
      propertiesConainter.view_notifier.propertyValue = LoginSuccess();
      setLoadingState(propertiesConainter.view_notifier);
    });
  }

  setLoadingState(LoginProperties property) {
    notifyListeners(property);
  }
}

class EmptyWithMessage extends Empty {
  final String message;

  EmptyWithMessage(this.message);

  @override
  List<Object> get props => [message];
}

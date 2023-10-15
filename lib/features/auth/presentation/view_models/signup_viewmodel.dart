import 'package:flutter/material.dart';
import 'package:todo_flutter/features/auth/domain/usecases/user_creation_request.dart';

import '../../../../core/parents/parent_property_notifier_view_model.dart';

import '../../../../core/router/route_constants.dart';
import '../../../../core/router/route_manager.dart';
import '../../../../core/states/view_loading_states.dart';
import '../change_notifier_properties/singup_change_notifier_properties.dart';

class SignUpViewModel extends ParentPropertyNotifierViewModel<
    SignUpPropertiesContainer, SignUpProperties, void> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool showSubmitButton = false;
  final UserCreationRequest sendOtp;

  SignUpViewModel(this.sendOtp);

  onFieldChange() {
    if (userNameTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty) {
      showSubmitButton = true;
    } else {
      showSubmitButton = false;
    }
    setLoadingState(propertiesConainter.view_notifier);
  }

  register() async {
    final result = await sendOtp.call(
      UserCreationRequestParams(
        email: emailTextController.text,
        userName: userNameTextController.text,
        password: passwordTextController.text,
      ),
    );

    result.fold((l) {
      propertiesConainter.view_notifier.propertyValue =
          Error("unable to register user");
      setLoadingState(propertiesConainter.view_notifier);
    }, (r) {
      propertiesConainter.view_notifier.propertyValue = Success();
      setLoadingState(propertiesConainter.view_notifier);
      RouteManager.navigateFromRouteString(RouteConstants.dashBoard);
    });
  }

  setLoadingState(SignUpProperties property) {
    notifyListeners(property);
  }
}

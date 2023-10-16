import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:todo_flutter/core/ds_widgets/ds_button.dart';
import 'package:todo_flutter/core/ds_widgets/ds_edit_text.dart';
import 'package:todo_flutter/core/res/dimens.dart';
import 'package:todo_flutter/core/res/styles/ac_text_styles.dart';

import '../../../../core/parents/parent_property_notifier_view.dart';
import '../../../../core/res/ac_colors.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/custom_progress_widget.dart';
import '../change_notifier_properties/singup_change_notifier_properties.dart';
import '../view_models/signup_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpView();
}

class _SignUpView extends ParentPropertyNotifierView<SignUpView,
    SignUpViewModel, SignUpPropertiesContainer, SignUpProperties> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getSignUpUi());
  }

  Widget getSignUpUi() {
    return PropertyChangeConsumer<SignUpViewModel, SignUpProperties>(
        properties: [viewModel.propertiesConainter.view_notifier],
        builder: (context, viewModel, child) {
          var state =
              viewModel!.propertiesConainter.view_notifier.propertyValue;
          if (state is Loading) {
            return CustomProgressWidget.getCustomProgressDialogWithMessage(
              Strings.LOADING,
            );
          } else if (state is Error) {
            showErrorPopUp(state.message);
            return Container();
          } else {
            return signUpForm();
          }
        });
  }

  Widget signUpForm() {
    return Container(
      color: AcColors.primaryLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_40),
            child: DSEditText(
              LoginStrings.EMAIL,
              false,
              viewModel.emailTextController,
              "invalid email",
              false,
              null,
            ),
          ),
          SizedBox(
            height: Dimens.dimen_20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_40),
            child: DSEditText(
              LoginStrings.NAME,
              false,
              viewModel.userNameTextController,
              "invalid username",
              false,
              null,
            ),
          ),
          SizedBox(
            height: Dimens.dimen_20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_40),
            child: DSEditText(
              LoginStrings.PASSWORD,
              false,
              viewModel.passwordTextController,
              "invalid password",
              false,
              null,
            ),
          ),
          SizedBox(
            height: Dimens.dimen_40,
          ),
          Container(
            height: Dimens.dimen_48,
            width: double.infinity,
            padding:
                EdgeInsets.only(left: Dimens.dimen_70, right: Dimens.dimen_70),
            child: DSButton(
              isLoading: false,
              onPressed: () {
                if (viewModel.showSubmitButton) {
                  viewModel.register();
                } else {
                  AppUtils.showToast(
                      "Please Provide the necessary information");
                }
              },
              lable: LoginStrings.REGISTER,
              textStyle: AcTextStyles.getWhite16dpBoldTextStyle(),
              topBottomPadding: Dimens.dimen_10,
              buttonType: ButtonType.primary,
              isDisabled: false,
            ),
          )
        ],
      ),
    );
  }

  void showErrorPopUp(String msg) {
    executeAfterRebuild(() => CustomDialog.getSimpleDialogWithSingleButton(
            context, msg, Strings.OK_MESSAGE, () {
          AppUtils.popScreen(context);
        }, () {
          AppUtils.popScreen(context);
        }, false));
  }
}

import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:todo_flutter/core/res/ac_colors.dart';
import 'package:todo_flutter/core/res/ac_images.dart';
import 'package:todo_flutter/features/auth/presentation/change_notifier_properties/login_notitifer_properties.dart';

import '../../../../core/ds_widgets/ds_button.dart';
import '../../../../core/ds_widgets/ds_edit_text.dart';
import '../../../../core/parents/parent_property_notifier_view.dart';
import '../../../../core/res/dimens.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/res/styles/ac_text_styles.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/router/route_manager.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/custom_progress_widget.dart';
import '../view_models/login_viewmodel.dart';
import '../view_states/login_success.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends ParentPropertyNotifierView<LoginView, LoginViewModel,
    LoginPropertiesContainer, LoginProperties> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AcColors.backgroundGrey,
      body: getLoginView(context),
    );
  }

  Widget getLoginView(BuildContext context) {
    return PropertyChangeConsumer<LoginViewModel, LoginProperties>(
      properties: [viewModel.propertiesConainter.view_notifier],
      builder: (context, viewModel, child) {
        var state = viewModel!.propertiesConainter.view_notifier.propertyValue;
        if (state is Loading) {
          return CustomProgressWidget.getCustomProgressDialogWithMessage(
            "",
          );
        } else if (state is LoginSuccess) {
          executeAfterRebuild(
            () =>
                RouteManager.navigateFromRouteString(RouteConstants.dashBoard),
          );
          return Container();
        } else if (state is Error) {
          AppUtils.showToast((state).message);

          return getLoginForm();
        } else {
          if (state is EmptyWithMessage) {
            AppUtils.showToast((state).message);
          }
          return getLoginForm();
        }
      },
    );
  }

  Widget getLoginForm() {
    return Container(
      color: AcColors.primaryLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_40),
            child: DSEditText(
              LoginStrings.USERNAME,
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
              true,
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
                viewModel.getAccessToken();
              },
              lable: LoginStrings.LOGIN,
              textStyle: AcTextStyles.getWhite20dpBoldTextStyle(),
              topBottomPadding: Dimens.dimen_0,
              buttonType: ButtonType.primary,
              isDisabled: false,
            ),
          ),
          SizedBox(
            height: Dimens.dimen_50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.signUp);
            },
            child: Container(
              margin: EdgeInsets.only(
                left: Dimens.dimen_50,
                right: Dimens.dimen_50,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.dimen_30),
                  color: AcColors.white,
                ),
                padding: EdgeInsets.only(
                  top: Dimens.dimen_10,
                  bottom: Dimens.dimen_10,
                  left: Dimens.dimen_20,
                  right: Dimens.dimen_20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LoginStrings.DONT_HAVE_ACCOUNT,
                          style: AcTextStyles.getBlack4016dpRegTextStyle(),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          LoginStrings.SEND_USER_CREATION_REQUEST,
                          style: AcTextStyles.getPrimary14dpSemiBoldTextStyle(),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimens.dimen_10),
                      child: Image.asset(AcImages.icNext),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

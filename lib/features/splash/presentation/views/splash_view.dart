import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/core/res/ac_colors.dart';
import 'package:todo_flutter/core/res/ac_images.dart';

import '../../../../core/parents/parent_state.dart';
import '../../../../core/res/dimens.dart';
import '../../../../core/router/route_constants.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../../core/widgets/ac_image_view.dart';
import '../../../auth/presentation/view_states/login_success.dart';
import '../view_models/splash_view_model.dart';
import '../view_states/login_error.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends ParentState<SplashView, SplashViewModel> {
  @override
  void initState() {
    super.initState();

    viewModel.checkForAutoLogin();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Dimens.initDimens(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getLayout(),
    );
  }

  Widget _getLayout() {
    return Consumer<SplashViewModel>(
      builder: (context, _, child) {
        if (viewModel.viewState is Loading) {
          return _getSplashAnimation();
        } else if (viewModel.viewState is Error) {
          if (viewModel.viewState is LoginError) {
            executeAfterRebuild(() =>
                Navigator.pushReplacementNamed(context, RouteConstants.login));
            return _getSplashAnimation();
          } else {
            return showErrorScreen((viewModel.viewState as Error).message);
          }
        } else if (viewModel.viewState is LoginSuccess) {
          executeAfterRebuild(() => Navigator.pushReplacementNamed(
              context, RouteConstants.dashBoard));
          return _getSplashAnimation();
        } else {
          return _getSplashAnimation();
        }
      },
    );
  }

  Widget _getSplashAnimation() {
    return Lottie.asset(AcImages.splashRepeatGif,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
  }

  Widget showErrorScreen(String message) {
    return Container(
      decoration: BoxDecoration(color: AcColors.white),
      child: Center(
        child: AcImageView.fromLocal(AcImages.splashError),
      ),
    );
  }
}

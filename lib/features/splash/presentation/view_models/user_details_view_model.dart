import '../../../../core/errors/network_failure.dart';
import '../../../../core/global_datasource/domain/params/get_user_params.dart';
import '../../../../core/global_datasource/domain/providers/global_data_provider_contract.dart';
import '../../../../core/network/enums/response_status.dart';
import '../../../../core/parents/parent_view_model.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../auth/presentation/view_states/login_success.dart';

class UserDetailsViewModel extends ParentViewModel {
  final GlobalDataProviderContract globalDataProvider;
  ViewLoadingState viewState = Loading();
  List<int>? companyIds;
  int? homePageId;
  List<int> locations = [];

  UserDetailsViewModel({
    required this.globalDataProvider,
  });

  getUser() async {
    final result =
        await globalDataProvider.getUser(GetUserParams(getUpdatedUser: true));
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
      setLoadingState(Error(failureMsg));
    }, (userResponse) async {
      setLoadingState(LoginSuccess());
    });
  }

  setLoadingState(ViewLoadingState state) {
    viewState = state;
    notifyListeners();
  }
}

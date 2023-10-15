import 'package:dio/dio.dart';

import '../../constants/application_constants.dart';
import '../../errors/network_failure.dart';
import '../../res/strings.dart';
import '../../utils/switch_401_manager.dart';
import '../contracts/network_failure_handler_contract.dart';
import '../enums/response_status.dart';

/// Used for Handling [NetworkFailure] during api calls.
class NetworkFailureHandler implements NetworkFailureHandlerContract {
  Switch401Manager switch401manager;
  NetworkFailureHandler(this.switch401manager);

  @override
  NetworkFailure handleFailure(dynamic failure) {
    if (failure is DioException) {
      switch (failure.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return _getInternetError();

        case DioExceptionType.badResponse:
          {
            handleCommonFailures(failure.response);
            if (failure.response != null &&
                failure.response?.data != null &&
                failure.response?.data is Map &&
                failure.response
                        ?.data[ApplicationConstants.NETWORK_FAILURE_MESSAGE] !=
                    null) {
              return NetworkFailure(
                  status: failure.response?.statusCode ?? 0,
                  message: failure.response
                      ?.data[ApplicationConstants.NETWORK_FAILURE_MESSAGE]);
            } else {
              return _getUnknownError();
            }
          }

        case DioExceptionType.unknown:
          {
            if (failure.message
                    ?.contains(ApplicationConstants.SOCKET_EXCEPTION_MATCHER) ==
                true) {
              return _getInternetError();
            } else {
              return _getUnknownError();
            }
          }

        default:
          return _getUnknownError();
      }
    } else {
      return _getUnknownError();
    }
  }

  handleCommonFailures(Response<dynamic>? response) {
    if (response != null && !switch401manager.getSwitchValue()) {
      if (response.statusCode == ResponseStatus.UNAUTHORIZED.value) {
        switch401manager.toggleSwitch(true);
        //TODO add logout here
        // AppUtils.logout(false);
      }
    }
  }

  NetworkFailure _getUnknownError() {
    return NetworkFailure(
        status: ResponseStatus.UNKNOWN_ERROR.value,
        message: Strings.UNKNOWN_ERROR);
  }

  NetworkFailure _getInternetError() {
    return NetworkFailure(
        status: ResponseStatus.INTERNET_ERROR.value,
        message: Strings.INTERNET_CONNECTION_ERROR);
  }
}

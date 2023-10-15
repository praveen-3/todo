import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo_flutter/core/constants/url_constants.dart';

import '../../../core/network/models/network_response.dart';
import '../../errors/failure.dart';
import '../../errors/network_failure.dart';
import '../contracts/network_failure_handler_contract.dart';
import '../contracts/network_manager_contract.dart';
import '../enums/request_method.dart';

/// Used for Network Calls
///
/// Uses [Dio] package for implementation
class NetworkManager implements NetworkManagerContract {
  final Dio dio;
  String? baseUrl;
  NetworkFailureHandlerContract failureHandler;

  NetworkManager(
      {required this.dio, required this.failureHandler, this.baseUrl});

  @override
  Future<Either<Failure, NetworkResponse>> request(
      String endpoint, RequestMethod method,
      {Map<String, dynamic>? queryParameters,
      data,
      Map<String, dynamic>? headers,
      Options? options,
      CancelToken? cancelToken}) async {
    baseUrl = UrlConstants.BASE_URL;

    try {
      Response<String> response = await dio.request(baseUrl! + endpoint,
          queryParameters: queryParameters,
          data: data,
          options: _checkOptions(method.value, options, headers),
          cancelToken: cancelToken);
      return Right(NetworkResponse(response: response));
    } catch (e) {
      return Left(failureHandler.handleFailure(e));
    }
  }

  Options _checkOptions(
      String method, Options? options, Map<String, dynamic>? headers) {
    options ??= Options();
    options.method = method;
    headers ??= {};
    options.headers ??= {};
    options.headers!.addAll(headers);
    return options;
  }

  @override
  Future<Either<Failure, NetworkResponse>> requestExternalUrl(
      String endpoint, RequestMethod method,
      {Map<String, dynamic>? queryParameters,
      data,
      Map<String, dynamic>? headers,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      Response<dynamic> response = await dio.request(endpoint,
          queryParameters: queryParameters,
          data: data,
          options: _checkOptions(method.value, options, headers),
          cancelToken: cancelToken);
      return Right(NetworkResponse(response: response));
    } catch (e) {
      return Left(failureHandler.handleFailure(e));
    }
  }

  @override
  String getReason(String endPoint, RequestMethod requestMethod,
      {NetworkFailure? failure, Map<String, dynamic>? data}) {
    return """
      EndPoint : $endPoint
      ${(data != null) ? "Data: $data" : ""}
      Request Type : ${requestMethod.value}
      ${(failure != null) ? "Status : ${failure.status}" : ""}
      ${(failure != null) ? "Message : ${failure.message}" : ""}
    """;
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../errors/failure.dart';
import '../../errors/network_failure.dart';
import '../enums/request_method.dart';
import '../models/network_response.dart';

abstract class NetworkManagerContract {
  /// Make Api call with given [url] and [method]
  ///
  /// Return [Future] of [Either] - [Failure] or [NetworkResponse]
  ///
  /// Params -
  /// * [endpoint] - given endpoint
  /// * [method] - for network request of [RequestMethod] type
  /// * [queryParameters] {optional} - for query parameters of api call
  /// * [data] {optional} - for request data for api call.
  /// * [headers] {optional} - for headers of api call.
  /// * [options] {optional} - for setting options for api call.
  /// * [cancelToken] {optional} - token for canceling the api call.
  Future<Either<Failure, NetworkResponse>> request(
      String endpoint, RequestMethod method,
      {Map<String, dynamic>? queryParameters,
      data,
      Map<String, dynamic>? headers,
      Options? options,
      CancelToken? cancelToken});

  Future<Either<Failure, NetworkResponse>> requestExternalUrl(
      String endpoint, RequestMethod method,
      {Map<String, dynamic>? queryParameters,
      data,
      Map<String, dynamic>? headers,
      Options? options,
      CancelToken? cancelToken});

  String getReason(String endPoint, RequestMethod requestMethod,
      {NetworkFailure? failure, Map<String, dynamic>? data});
}

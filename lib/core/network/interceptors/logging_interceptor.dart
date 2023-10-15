import 'dart:convert';

import 'package:dio/dio.dart';

import '../../logger/enum/logger_value.dart';
import '../../logger/logger.dart';

/// Extends [Interceptor] class
///
/// Used for Intercepting Api Calls for Logging the Data
class LoggingInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.log(value: '-----------------------Request-----------------------');

    _startTime = DateTime.now();
    _renderCurlRepresentation(options);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.log(value: '-----------------------Error-----------------------');

    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;

    _renderCurlRepresentation(err.requestOptions);

    Logger.log(value: 'Time Taken: $duration');
    Logger.log(value: 'Error Message: ${err.message}');
    if (err.response != null) {
      Logger.log(value: 'Error Response Code: ${err.response!.statusCode}');
      Logger.log(value: 'Error Response Data: ${err.response!.data}');
    } else {
      Logger.log(value: 'Error Response Code: Error Response is null');
      Logger.log(value: 'Error Response Data: Error Response is null');
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.log(value: '-----------------------Response-----------------------');

    _renderCurlRepresentation(response.requestOptions);

    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;

    Logger.log(value: 'Time Taken: $duration');
    Logger.log(value: 'Response Code: ${response.statusCode}');
    Logger.log(value: 'Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    try {
      Logger.log(value: _cURLRepresentation(requestOptions));
    } catch (e, s) {
      Logger.log(
          value:
              'unable to create a CURL representation of the requestOptions');
      Logger.log(
          error: e, stackTrace: s, logValue: LoggerValue.FIREBASE_CRASHLYTICS);
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}

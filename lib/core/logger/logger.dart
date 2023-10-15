import 'dart:developer' as dev;

import 'enum/logger_value.dart';

class Logger {
  static void log({
    Object? value,
    LoggerValue logValue = LoggerValue.CONSOLE,
    StackTrace? stackTrace,
    Object? error,
  }) {
    switch (logValue) {
      case LoggerValue.CONSOLE:
        if (value != null && value is String) {
          dev.log(value);
        }
        break;
      case LoggerValue.FIREBASE_CRASHLYTICS:
        //TODO implement firebase crashlytics to log in server side
        break;
    }
  }
}

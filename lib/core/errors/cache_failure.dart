import 'package:equatable/equatable.dart';

import 'failure.dart';

class CacheFailure extends Equatable implements Failure {
  final String message;

  const CacheFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CacheExceptionFailure extends CacheFailure {
  const CacheExceptionFailure(String message) : super(message: message);
}

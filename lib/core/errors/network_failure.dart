import 'package:equatable/equatable.dart';

import 'failure.dart';

class NetworkFailure extends Equatable implements Failure {
  final int status;
  final String message;

  const NetworkFailure({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}

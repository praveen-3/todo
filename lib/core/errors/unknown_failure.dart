import 'package:equatable/equatable.dart';

import '../res/strings.dart';
import 'failure.dart';

class UnknownFailure extends Equatable implements Failure {
  final message = Strings.UNKNOWN_ERROR;
  const UnknownFailure();

  @override
  List<Object> get props => [];
}

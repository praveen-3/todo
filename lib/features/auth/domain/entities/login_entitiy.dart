import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LoginEntity extends Equatable {
  // ignore: non_constant_identifier_names
  String? access_token;
  String? scope;

  @override
  List<Object?> get props => [access_token, scope];
}

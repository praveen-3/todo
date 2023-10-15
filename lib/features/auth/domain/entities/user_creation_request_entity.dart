import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserCreationRequestEntity extends Equatable {
  String? message;
  String? uid;

  @override
  List<Object?> get props => [message, uid];
}

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LogoutEntity extends Equatable {
  bool? active;

  @override
  List<Object?> get props => [active];
}

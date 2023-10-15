import 'package:equatable/equatable.dart';

abstract class ViewLoadingState extends Equatable {}

class Loading extends ViewLoadingState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class Success extends ViewLoadingState {
  @override
  List<Object?> get props => [];
}

class Error extends ViewLoadingState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class Empty extends ViewLoadingState {
  @override
  List<Object> get props => [];
}

import '../../../../core/states/view_loading_states.dart';

class LoginError extends Error {
  final String message;
  LoginError(this.message) : super(message);
}

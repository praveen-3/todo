import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetUserParams extends Equatable {
  bool getUpdatedUser;
  int? id;
  GetUserParams({this.getUpdatedUser = false, this.id});
  @override
  List<Object?> get props => [getUpdatedUser, id];
}

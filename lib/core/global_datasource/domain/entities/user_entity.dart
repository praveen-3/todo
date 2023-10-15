import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  int? id;
  String? name;
  String? email;
  String? username;
  int? companyId;
  String? mobileNo;
  int? active;
  num? lastActive;
  int? lastNotificationRead;
  List<String>? scopes;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        companyId,
        mobileNo,
        active,
        lastActive,
        lastNotificationRead,
        scopes
      ];
}

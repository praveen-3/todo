import 'package:equatable/equatable.dart';

import 'user_entity.dart';

// ignore: must_be_immutable
class UserDataEntity<T extends UserEntity> extends Equatable {
  T? data;

  @override
  List<Object?> get props => [data];
}

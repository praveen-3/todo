import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AcImageEntity extends Equatable {
  String? imageName;
  String? imageUrl;

  AcImageEntity({this.imageName, this.imageUrl});

  @override
  List<Object?> get props => [imageName, imageUrl];
}

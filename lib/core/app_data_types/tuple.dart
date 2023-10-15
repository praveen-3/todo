import 'package:equatable/equatable.dart';

class Tuple<T, U> extends Equatable {
  final T first;
  final U second;

  const Tuple(this.first, this.second);

  @override
  List<Object?> get props => [first, second];

  Map<String, dynamic> toJson(dynamic json1, dynamic json2) {
    Map<String, dynamic> data = {};
    if (json1 != null) data["first"] = json1;
    if (json2 != null) data["second"] = json2;
    return data;
  }
}

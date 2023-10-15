import '../../../domain/entities/user_data_entity.dart';
import 'user_restful_model.dart';

// ignore: must_be_immutable
class UserDataRestfulModel extends UserDataEntity<UserRestfulModel> {
  UserRestfulModel? data;

  UserDataRestfulModel({this.data});

  UserDataRestfulModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null && json["data"] is Map<String, dynamic>) {
      data = new UserRestfulModel.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data["data"] = this.data!.toJson();
    }
    return data;
  }
}

import '../../domain/entities/login_entitiy.dart';

// ignore: must_be_immutable
class LoginRestfulModel extends LoginEntity {
  // ignore: non_constant_identifier_names
  String? access_token;
  String? scope;

  LoginRestfulModel.fromJson(Map<String, dynamic> json) {
    if (json["access_token"] != null && json["access_token"] is String) {
      access_token = json["access_token"];
    }
    if (json["scope"] != null && json["scope"] is String) {
      scope = json["scope"];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["access_token"] = access_token;
    data["scope"] = scope;
    return data;
  }
}

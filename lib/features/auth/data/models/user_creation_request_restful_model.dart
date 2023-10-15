import '../../domain/entities/user_creation_request_entity.dart';

// ignore: must_be_immutable
class UserCreationRequestRestfulModel extends UserCreationRequestEntity {
  UserCreationRequestRestfulModel.fromJson(Map<String, dynamic> json) {
    if (json["message"] != null && json["message"] is String) {
      message = json["message"];
    }
    if (json["uid"] != null && json["uid"] is String) {
      uid = json["uid"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["message"] = message;
    data["uid"] = uid;
    return data;
  }
}

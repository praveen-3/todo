import '../../../domain/entities/logout_entity.dart';

// ignore: must_be_immutable
class LogoutRestfulModel extends LogoutEntity {
  bool? active;

  LogoutRestfulModel.fromJson(Map<String, dynamic> json) {
    if (json["active"] != null && json["active"] is bool) {
      active = json["active"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["active"] = this.active;
    return data;
  }
}

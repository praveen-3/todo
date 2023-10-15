import '../../../domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserRestfulModel extends UserEntity {
  int? id;
  String? name;
  String? email;
  String? username;
  int? companyId;
  String? mobileNo;
  int? active;
  num? lastActive;
  List<String>? scopes;

  UserRestfulModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null && json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] != null && json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] != null && json["email"] is String) {
      email = json["email"];
    }
    if (json["username"] != null && json["username"] is String) {
      username = json["username"];
    }
    if (json["company_id"] != null && json["company_id"] is int) {
      companyId = json["company_id"];
    }
    if (json["mobile_no"] != null && json["mobile_no"] is String) {
      mobileNo = json["mobile_no"];
    }
    if (json["active"] != null && json["active"] is int) {
      active = json["active"];
    }
    if (json["last_active"] != null && json["last_active"] is num) {
      lastActive = json["last_active"];
    }
    if (json["last_notification_read"] != null &&
        json["last_notification_read"] is num) {
      lastNotificationRead = (json["last_notification_read"] as num).toInt();
    }

    if (json["scopes"] != null && json["scopes"] is List) {
      scopes = [];
      json["scopes"].forEach((v) {
        if (v is String) {
          scopes?.add(v);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["email"] = this.email;
    data["username"] = this.username;
    data["company_id"] = this.companyId;

    data["mobile_no"] = this.mobileNo;
    data["active"] = this.active;
    data["last_active"] = this.lastActive;
    data["last_notification_read"] = this.lastNotificationRead;

    data["scopes"] = this.scopes;
    return data;
  }
}

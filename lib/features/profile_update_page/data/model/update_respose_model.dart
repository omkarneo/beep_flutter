import 'dart:convert';

import 'package:beep/features/profile_update_page/domain/entity/update_response_entity.dart';

class ProfileUpdateResponseModel extends ProfileUpdateResponseEntity {
  String? status;
  String? message;

  ProfileUpdateResponseModel({
    this.status,
    this.message,
  }) : super(message: message, status: status);

  factory ProfileUpdateResponseModel.fromRawJson(String str) =>
      ProfileUpdateResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

import 'dart:convert';

import 'package:beep/features/status_upload/domain/entity/add_status_response_entity.dart';

class StatusAddResponsetModel extends StatusAddResponsetEntity {
  String? status;
  String? message;

  StatusAddResponsetModel({
    this.status,
    this.message,
  });

  factory StatusAddResponsetModel.fromRawJson(String str) =>
      StatusAddResponsetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusAddResponsetModel.fromJson(Map<String, dynamic> json) =>
      StatusAddResponsetModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

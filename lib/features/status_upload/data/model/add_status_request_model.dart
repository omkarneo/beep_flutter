import 'dart:convert';

import 'package:beep/features/status_upload/domain/entity/add_status_request_entity.dart';

class StatusAddRequestModel extends StatusAddRequestEntity {
  String? stausMessage;
  String? statusImage;
  String? statusType;

  StatusAddRequestModel({
    this.stausMessage,
    this.statusImage,
    this.statusType,
  });

  factory StatusAddRequestModel.fromRawJson(String str) =>
      StatusAddRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusAddRequestModel.fromJson(Map<String, dynamic> json) =>
      StatusAddRequestModel(
        stausMessage: json["stausMessage"],
        statusImage: json["statusImage"],
        statusType: json["statusType"],
      );

  Map<String, dynamic> toJson() => {
        "stausMessage": stausMessage,
        "statusImage": statusImage,
        "statusType": statusType,
      };
}

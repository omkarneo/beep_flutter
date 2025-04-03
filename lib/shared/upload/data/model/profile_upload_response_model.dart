import 'dart:convert';

import 'package:beep/shared/upload/domain/entity/profile_upload_response_entity.dart';

class ProfileUploadModel extends ProfileUploadEntity {
  String? message;
  String? fileUrl;

  ProfileUploadModel({
    this.message,
    this.fileUrl,
  });

  factory ProfileUploadModel.fromRawJson(String str) =>
      ProfileUploadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileUploadModel.fromJson(Map<String, dynamic> json) =>
      ProfileUploadModel(
        message: json["message"],
        fileUrl: json["fileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "fileUrl": fileUrl,
      };
}

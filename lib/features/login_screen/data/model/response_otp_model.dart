import 'dart:convert';

import 'package:beep/features/login_screen/domain/entity/otp_response_entity.dart';

class OtpResponseModel extends OtpResponseEntity {
  String? status;
  bool? newAccount;
  Data? data;
  String? message;

  OtpResponseModel({this.status, this.data, this.newAccount, this.message});

  factory OtpResponseModel.fromRawJson(String str) =>
      OtpResponseModel.fromJson(json.decode(str));

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
        status: json["status"],
        newAccount: json['newAccount'],
        message: json['message'],
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );
}

class DataModel extends Data {
  String? token;
  String? name;
  String? id;

  DataModel({this.token, this.id, this.name});

  factory DataModel.fromRawJson(String str) =>
      DataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        token: json["token"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

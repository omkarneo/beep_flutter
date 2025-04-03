import 'dart:convert';

import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/features/dashboard/domain/entity/get_self_status_response.dart';
import 'package:beep/utils/constants/url_constants.dart';

class SelfStatusResponeModel extends StatusSelfResponeEntity {
  String? status;
  String? message;
  StatusUserData? data;

  SelfStatusResponeModel({
    this.status,
    this.message,
    this.data,
  });

  factory SelfStatusResponeModel.fromRawJson(String str) =>
      SelfStatusResponeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelfStatusResponeModel.fromJson(Map<String, dynamic> json) =>
      SelfStatusResponeModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : StatusUserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class StatusUserData {
  String? username;
  String? userphotos;
  Status? statusdata;

  StatusUserData({
    this.username,
    this.userphotos,
    this.statusdata,
  });

  factory StatusUserData.fromRawJson(String str) =>
      StatusUserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusUserData.fromJson(Map<String, dynamic> json) => StatusUserData(
        username: json["username"],
        userphotos: "$baseUrl${json["userphotos"]}",
        statusdata: json["statusdata"] == null
            ? null
            : Status.fromJson(json["statusdata"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "userphotos": userphotos,
        "statusdata": statusdata?.toJson(),
      };
}

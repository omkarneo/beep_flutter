import 'dart:convert';

import 'package:beep/features/dashboard/domain/entity/profile_entity.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/base_url_helper.dart';

class ProfileResponseModel extends ProfileResponseEntity {
  String? status;
  DataProfile? data;

  ProfileResponseModel({
    this.status,
    this.data,
  });

  factory ProfileResponseModel.fromRawJson(String str) =>
      ProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : DataProfile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class DataProfile {
  Auth? auth;
  String? id;
  String? phonenumber;
  int? v;
  String? email;
  String? firstName;
  String? lastName;
  String? photos;

  DataProfile({
    this.auth,
    this.id,
    this.phonenumber,
    this.v,
    this.email,
    this.firstName,
    this.lastName,
    this.photos,
  });

  factory DataProfile.fromRawJson(String str) =>
      DataProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
        auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
        id: json["_id"],
        phonenumber: json["phonenumber"],
        v: json["__v"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        photos: "${AppUrl.baseUrl}${json["photos"]}",
      );

  Map<String, dynamic> toJson() => {
        "auth": auth?.toJson(),
        "_id": id,
        "phonenumber": phonenumber,
        "__v": v,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "photos": photos,
      };
}

class Auth {
  String? otp;
  DateTime? createDate;
  DateTime? expiryDate;

  Auth({
    this.otp,
    this.createDate,
    this.expiryDate,
  });

  factory Auth.fromRawJson(String str) => Auth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        otp: json["otp"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "createDate": createDate?.toIso8601String(),
        "expiryDate": expiryDate?.toIso8601String(),
      };
}

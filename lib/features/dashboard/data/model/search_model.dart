import 'dart:convert';

import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/base_url_helper.dart';

class SearchResponseModel {
  String? status;
  List<UserData>? data;

  SearchResponseModel({
    this.status,
    this.data,
  });

  factory SearchResponseModel.fromRawJson(String str) =>
      SearchResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserData {
  String? phonenumber;
  String? id;
  String? firstName;
  String? lastName;
  String? photos;

  UserData(
      {this.phonenumber, this.firstName, this.lastName, this.photos, this.id});

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      phonenumber: json["phonenumber"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      photos:
          json["photos"] == null ? null : "${AppUrl.baseUrl}${json["photos"]}",
      id: json["_id"]);

  Map<String, dynamic> toJson() => {
        "phonenumber": phonenumber,
        "firstName": firstName,
        "lastName": lastName,
        "photos": photos,
      };
}

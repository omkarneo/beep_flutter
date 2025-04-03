import 'dart:convert';

import 'package:beep/features/dashboard/domain/entity/status_response_entity.dart';
import 'package:beep/utils/constants/url_constants.dart';

class StatusResponeModel extends StatusChatResponeEntity {
  String? status;
  List<Status>? data;

  StatusResponeModel({
    this.status,
    this.data,
  });

  factory StatusResponeModel.fromRawJson(String str) =>
      StatusResponeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusResponeModel.fromJson(Map<String, dynamic> json) =>
      StatusResponeModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Status>.from(json["data"]!.map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Status {
  String? id;
  String? userId;
  String? userphonenumber;
  String? username;
  String? stausMessage;
  String? statusImage;
  String? statusType;
  DateTime? timestamp;
  String? userPhotos;
  int? v;

  Status({
    this.id,
    this.userId,
    this.userphonenumber,
    this.username,
    this.stausMessage,
    this.statusImage,
    this.statusType,
    this.timestamp,
    this.userPhotos,
    this.v,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["_id"],
        userId: json["userId"],
        userphonenumber: json["userphonenumber"],
        username: json["username"],
        stausMessage: json["stausMessage"],
        statusImage: json["statusImage"] == null
            ? null
            : "$baseUrl${json["statusImage"]}",
        statusType: json["statusType"],
        userPhotos: "$baseUrl${json['userphotos']}",
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "userphonenumber": userphonenumber,
        "username": username,
        "stausMessage": stausMessage,
        "statusImage": statusImage,
        "statusType": statusType,
        "timestamp": timestamp?.toIso8601String(),
        "__v": v,
      };
}

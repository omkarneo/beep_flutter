import 'dart:convert';

import 'package:beep/features/dashboard/domain/entity/room_entity.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/base_url_helper.dart';

class RoomResponseModel extends RoomResponseEntity {
  String? status;
  List<RoomData>? data;

  RoomResponseModel({
    this.status,
    this.data,
  });

  factory RoomResponseModel.fromRawJson(String str) =>
      RoomResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomResponseModel.fromJson(Map<String, dynamic> json) =>
      RoomResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<RoomData>.from(
                json["data"]!.map((x) => RoomData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RoomData {
  String? roomId;
  String? recevierid;
  String? receviernumber;
  String? recevierName;
  String? id;
  String? lastchat;
  String? recevierphoto;
  String? lastchatTime;
  bool? hasBeenRead;
  int? unReadCount;

  RoomData(
      {this.roomId,
      this.recevierid,
      this.receviernumber,
      this.recevierName,
      this.id,
      this.lastchat,
      this.lastchatTime,
      this.recevierphoto,
      this.hasBeenRead,
      this.unReadCount});

  factory RoomData.fromRawJson(String str) =>
      RoomData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
      roomId: json["roomId"],
      recevierid: json["recevierid"],
      receviernumber: json["receviernumber"],
      recevierName: json["recevierName"],
      id: json["_id"],
      lastchat: json["lastchat"],
      lastchatTime: json['lastchatTime'],
      hasBeenRead: json['hasBeenRead'],
      unReadCount: json['unReadCount'],
      recevierphoto: "${AppUrl.baseUrl}${json['recevierphoto']}");

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "recevierid": recevierid,
        "receviernumber": receviernumber,
        "recevierName": recevierName,
        "hasBeenRead": hasBeenRead,
        "_id": id,
        "unReadCount": unReadCount
      };
}

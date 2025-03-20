import 'dart:convert';

import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';

class CreateRoomResponseModel extends CreateRoomResponseEntity {
  String? status;
  String? message;
  String roomid;

  CreateRoomResponseModel({this.status, this.message, required this.roomid})
      : super(roomid: roomid);

  factory CreateRoomResponseModel.fromRawJson(String str) =>
      CreateRoomResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateRoomResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateRoomResponseModel(
        status: json["status"],
        message: json["message"],
        roomid: json["roomId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

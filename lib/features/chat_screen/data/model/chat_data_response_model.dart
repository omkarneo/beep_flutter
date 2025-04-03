import 'dart:convert';

import 'package:beep/features/chat_screen/domain/entity/chat_data_response_entity.dart';
import 'package:beep/utils/constants/url_constants.dart';

class ChatRoomResponseModel extends ChatDataResponseEntity {
  String? status;
  List<ChatRoomMessage>? data;
  String? receiverStatus;

  ChatRoomResponseModel({
    this.status,
    this.data,
    this.receiverStatus,
  });

  factory ChatRoomResponseModel.fromRawJson(String str) =>
      ChatRoomResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatRoomResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatRoomResponseModel(
        status: json["status"],
        receiverStatus: json["receiverStatus"],
        data: json["data"] == null
            ? []
            : List<ChatRoomMessage>.from(
                json["data"]!.map((x) => ChatRoomMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "receiverStatus": receiverStatus,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChatRoomMessage {
  String? senderId;
  String? senderNumber;
  String? senderName;
  String? message;
  DateTime? timestamp;
  String? id;
  String? messagetype;
  String? image;

  ChatRoomMessage({
    this.senderId,
    this.senderNumber,
    this.senderName,
    this.message,
    this.timestamp,
    this.image,
    this.messagetype,
    this.id,
  });

  factory ChatRoomMessage.fromRawJson(String str) =>
      ChatRoomMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatRoomMessage.fromJson(Map<String, dynamic> json) =>
      ChatRoomMessage(
          senderId: json["senderId"],
          senderNumber: json["senderNumber"],
          senderName: json["senderName"],
          message: json["message"],
          timestamp: json["timestamp"] == null
              ? null
              : DateTime.parse(json["timestamp"]),
          id: json["_id"],
          image: "$baseUrl${json['image']}",
          messagetype: json['messagetype']);

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "senderNumber": senderNumber,
        "senderName": senderName,
        "message": message,
        "timestamp": timestamp?.toIso8601String(),
        "_id": id,
      };
}

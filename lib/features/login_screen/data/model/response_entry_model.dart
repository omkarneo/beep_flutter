import 'dart:convert';

import 'package:chat_app/features/login_screen/domain/entity/response_entry_entity.dart';

class EntryResponseModel extends EntryResponseEntity {
  final String? status;
  final String? message;

  EntryResponseModel({
    this.status,
    this.message,
  }) : super(message: message, status: status);

  factory EntryResponseModel.fromRawJson(String str) =>
      EntryResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntryResponseModel.fromJson(Map<String, dynamic> json) =>
      EntryResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

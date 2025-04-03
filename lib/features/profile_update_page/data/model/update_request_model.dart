import 'dart:convert';

import 'package:beep/features/profile_update_page/domain/entity/update_request_entity.dart';

class ProfileUpdateRequesModel extends ProfileUpdateRequestEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? photos;

  ProfileUpdateRequesModel({
    this.firstName,
    this.lastName,
    this.email,
    this.photos,
  }) : super(
            email: email,
            firstName: firstName,
            lastName: lastName,
            photos: photos);

  factory ProfileUpdateRequesModel.fromRawJson(String str) =>
      ProfileUpdateRequesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileUpdateRequesModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateRequesModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        photos: json["photos"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "photos": photos,
      };
}

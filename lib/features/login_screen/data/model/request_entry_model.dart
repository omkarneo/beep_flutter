import 'package:chat_app/features/login_screen/domain/entity/entry_request_entity.dart';

class EntryRequestModel extends EntryRequestEntity {
  final String phonenumber;

  EntryRequestModel({required this.phonenumber})
      : super(phonenumber: phonenumber);

  factory EntryRequestModel.fromJson(Map<String, dynamic> json) =>
      EntryRequestModel(
        phonenumber: json["phonenumber"],
      );

  Map<String, dynamic> toJson() => {
        "number": phonenumber,
      };
}

class OtpRequestModel extends OTPRequestEntity {
  final String phonenumber;
  final String otp;

  OtpRequestModel({required this.phonenumber, required this.otp})
      : super(phonenumber: phonenumber, otp: otp);

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestModel(
        phonenumber: json["phonenumber"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "number": phonenumber,
        "otp": otp,
      };
}

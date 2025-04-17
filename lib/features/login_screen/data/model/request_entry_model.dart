import 'package:beep/features/login_screen/domain/entity/entry_request_entity.dart';

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
  final String token;

  OtpRequestModel(
      {required this.phonenumber, required this.otp, required this.token})
      : super(phonenumber: phonenumber, otp: otp, token: token);

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestModel(
          phonenumber: json["phonenumber"],
          otp: json["otp"],
          token: json['token']);

  Map<String, dynamic> toJson() =>
      {"number": phonenumber, "otp": otp, "token": token};
}

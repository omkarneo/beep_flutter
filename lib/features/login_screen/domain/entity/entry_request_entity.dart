class EntryRequestEntity {
  final String phonenumber;

  EntryRequestEntity({required this.phonenumber});
}

class OTPRequestEntity {
  final String phonenumber;
  final String otp;

  OTPRequestEntity({required this.phonenumber, required this.otp});
}

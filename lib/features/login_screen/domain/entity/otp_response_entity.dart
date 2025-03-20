class OtpResponseEntity {
  String? status;
  bool? newAccount;
  Data? data;
  String? message;

  OtpResponseEntity({this.status, this.data, this.newAccount});
}

class Data {
  String? token;
  String? name;
  String? id;

  Data({this.token, this.id, this.name});
}

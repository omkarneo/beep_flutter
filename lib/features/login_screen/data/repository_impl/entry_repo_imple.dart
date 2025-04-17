import 'package:beep/features/login_screen/data/data_source/entry_datasource.dart';
import 'package:beep/features/login_screen/data/model/request_entry_model.dart';
import 'package:beep/features/login_screen/data/model/response_otp_model.dart';
import 'package:beep/features/login_screen/domain/entity/entry_request_entity.dart';
import 'package:beep/features/login_screen/domain/entity/otp_response_entity.dart';
import 'package:beep/features/login_screen/domain/entity/response_entry_entity.dart';
import 'package:beep/features/login_screen/domain/repository/entry_repo.dart';

class EntryRepoImple extends EntryRepo {
  final EntryDataSource entryDataSource;
  EntryRepoImple({required this.entryDataSource});
  @override
  Future<EntryResponseEntity> authentication(
      EntryRequestEntity requestEntity) async {
    print("In repo imple");
    return await entryDataSource.entryApiCall(
        EntryRequestModel(phonenumber: requestEntity.phonenumber));
  }

  @override
  Future<OtpResponseModel> verifyOtp(OTPRequestEntity requestEntity) async {
    return await entryDataSource.otpVerifyApiCall(OtpRequestModel(
        phonenumber: requestEntity.phonenumber,
        otp: requestEntity.otp,
        token: requestEntity.token));
  }
}

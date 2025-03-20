import 'package:chat_app/features/login_screen/data/model/response_otp_model.dart';
import 'package:chat_app/features/login_screen/domain/entity/entry_request_entity.dart';
import 'package:chat_app/features/login_screen/domain/entity/otp_response_entity.dart';
import 'package:chat_app/features/login_screen/domain/entity/response_entry_entity.dart';

abstract class EntryRepo {
  Future<EntryResponseEntity> authentication(EntryRequestEntity requestEntity);
  Future<OtpResponseEntity> verifyOtp(OTPRequestEntity requestEntity);
}

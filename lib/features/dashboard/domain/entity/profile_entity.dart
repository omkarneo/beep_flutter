import 'package:beep/features/dashboard/data/model/profile_model.dart';
import 'package:beep/features/login_screen/domain/entity/otp_response_entity.dart';

class ProfileResponseEntity {
  String? status;
  DataProfile? data;

  ProfileResponseEntity({
    this.status,
    this.data,
  });
}

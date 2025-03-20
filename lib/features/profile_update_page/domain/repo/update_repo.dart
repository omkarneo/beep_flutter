import 'package:chat_app/features/profile_update_page/domain/entity/update_request_entity.dart';
import 'package:chat_app/features/profile_update_page/domain/entity/update_response_entity.dart';

abstract class UpdateRepo {
  Future<ProfileUpdateResponseEntity> updateProfile(
      ProfileUpdateRequestEntity data);
}

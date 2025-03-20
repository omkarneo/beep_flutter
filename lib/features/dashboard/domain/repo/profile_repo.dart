import 'package:chat_app/features/dashboard/domain/entity/profile_entity.dart';

abstract class ProfileRepo {
  Future<ProfileResponseEntity> getProfileData();
}

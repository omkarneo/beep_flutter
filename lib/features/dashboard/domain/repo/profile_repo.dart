import 'package:beep/features/dashboard/domain/entity/profile_entity.dart';

abstract class ProfileRepo {
  Future<ProfileResponseEntity> getProfileData();
}

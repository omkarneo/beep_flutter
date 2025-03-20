import 'package:chat_app/features/profile_update_page/data/data_source/update_datasource.dart';
import 'package:chat_app/features/profile_update_page/data/model/update_request_model.dart';
import 'package:chat_app/features/profile_update_page/domain/entity/update_request_entity.dart';
import 'package:chat_app/features/profile_update_page/domain/entity/update_response_entity.dart';
import 'package:chat_app/features/profile_update_page/domain/repo/update_repo.dart';

class UpdateRepoImpl extends UpdateRepo {
  final ProfileDataSource profileDataSource;

  UpdateRepoImpl({required this.profileDataSource});

  @override
  Future<ProfileUpdateResponseEntity> updateProfile(
      ProfileUpdateRequestEntity data) async {
    return await profileDataSource.entryApiCall(ProfileUpdateRequesModel(
        email: data.email,
        firstName: data.firstName,
        lastName: data.lastName,
        photos: data.photos));
  }
}

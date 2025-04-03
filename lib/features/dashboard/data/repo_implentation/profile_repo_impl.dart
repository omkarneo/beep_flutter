import 'package:beep/features/dashboard/data/datasource/profile_ds.dart';
import 'package:beep/features/dashboard/domain/entity/profile_entity.dart';
import 'package:beep/features/dashboard/domain/repo/profile_repo.dart';
import 'package:beep/features/profile_update_page/data/data_source/update_datasource.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileGetDataSource profileGetDataSource;
  ProfileRepoImpl({required this.profileGetDataSource});
  @override
  Future<ProfileResponseEntity> getProfileData() async {
    return await profileGetDataSource.profileApiCall();
  }
}

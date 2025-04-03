import 'package:beep/features/dashboard/domain/entity/profile_entity.dart';
import 'package:beep/features/dashboard/domain/repo/profile_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class GetProfileData extends UseCase {
  final ProfileRepo profileRepo;
  GetProfileData({required this.profileRepo});
  @override
  Future<ProfileResponseEntity> call({required params}) async {
    return await profileRepo.getProfileData();
  }
}

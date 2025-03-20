import 'package:chat_app/features/profile_update_page/domain/repo/update_repo.dart';
import 'package:chat_app/utils/base_usecase.dart';

class ProfileUpdateUseCase extends UseCase {
  UpdateRepo updateRepo;
  ProfileUpdateUseCase({required this.updateRepo});
  @override
  Future call({required params}) async {
    return await updateRepo.updateProfile(params);
  }
}

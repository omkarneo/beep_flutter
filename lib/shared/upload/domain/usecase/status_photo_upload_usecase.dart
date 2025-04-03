import 'package:beep/features/chat_screen/domain/repo/chat_data_repo.dart';
import 'package:beep/shared/upload/domain/entity/profile_upload_response_entity.dart';
import 'package:beep/shared/upload/domain/repo/profile_photo_upload_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class StatusPhotoUploadUsecase extends UseCase {
  final PhotoUploadRepo photoUploadRepo;
  StatusPhotoUploadUsecase({required this.photoUploadRepo});

  @override
  Future<ProfileUploadEntity> call({required params}) {
    return photoUploadRepo.uploadPhoto(params, "Status");
  }
}

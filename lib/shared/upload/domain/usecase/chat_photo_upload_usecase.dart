import 'package:chat_app/shared/upload/domain/entity/profile_upload_response_entity.dart';
import 'package:chat_app/shared/upload/domain/repo/profile_photo_upload_repo.dart';
import 'package:chat_app/utils/base_usecase.dart';

class ChatPhotoUploadUsecase extends UseCase {
  final PhotoUploadRepo photoUploadRepo;
  ChatPhotoUploadUsecase({required this.photoUploadRepo});

  @override
  Future<ProfileUploadEntity> call({required params}) {
    return photoUploadRepo.uploadPhoto(params, "chats");
  }
}

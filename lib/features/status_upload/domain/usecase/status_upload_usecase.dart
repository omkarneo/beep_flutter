import 'package:beep/features/status_upload/domain/repo/status_photo_upload.dart';
import 'package:beep/shared/upload/data/model/profile_upload_response_model.dart';
import 'package:beep/utils/base_usecase.dart';

class StatusUploadUsecase extends UseCase {
  final StatusPhotoRepoUpload statusPhotoUpload;
  StatusUploadUsecase({required this.statusPhotoUpload});
  @override
  Future<ProfileUploadModel> call({required params}) {
    return statusPhotoUpload.upload(params);
  }
}

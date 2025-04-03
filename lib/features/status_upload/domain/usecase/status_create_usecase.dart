import 'package:beep/features/status_upload/domain/entity/add_status_response_entity.dart';
import 'package:beep/features/status_upload/domain/repo/status_photo_upload.dart';
import 'package:beep/utils/base_usecase.dart';

class StatusCreateUsecase extends UseCase {
  final StatusPhotoRepoUpload statusPhotoUpload;
  StatusCreateUsecase({required this.statusPhotoUpload});
  @override
  Future<StatusAddResponsetEntity> call({required params}) {
    return statusPhotoUpload.create(params);
  }
}

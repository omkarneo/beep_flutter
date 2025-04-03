import 'dart:io';

import 'package:beep/features/status_upload/domain/entity/add_status_request_entity.dart';
import 'package:beep/features/status_upload/domain/entity/add_status_response_entity.dart';
import 'package:beep/shared/upload/data/model/profile_upload_response_model.dart';

abstract class StatusPhotoRepoUpload {
  Future<ProfileUploadModel> upload(File file);
  Future<StatusAddResponsetEntity> create(
      StatusAddRequestEntity statusAddRequestEntity);
}

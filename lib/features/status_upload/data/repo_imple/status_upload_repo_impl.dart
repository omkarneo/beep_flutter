import 'dart:io';

import 'package:beep/features/status_upload/data/data_source/status_upload_ds.dart';
import 'package:beep/features/status_upload/data/model/add_status_request_model.dart';
import 'package:beep/features/status_upload/domain/entity/add_status_request_entity.dart';
import 'package:beep/features/status_upload/domain/entity/add_status_response_entity.dart';
import 'package:beep/features/status_upload/domain/repo/status_photo_upload.dart';
import 'package:beep/shared/upload/data/model/profile_upload_response_model.dart';

class StatusUploadRepoImpl extends StatusPhotoRepoUpload {
  final UploadStatusSource uploadStatusSource;
  StatusUploadRepoImpl({required this.uploadStatusSource});

  @override
  Future<ProfileUploadModel> upload(File file) {
    return uploadStatusSource.uploadApiCall(file);
  }

  @override
  Future<StatusAddResponsetEntity> create(
      StatusAddRequestEntity statusAddRequestEntity) {
    return uploadStatusSource.createStatusApiCall(StatusAddRequestModel(
        statusImage: statusAddRequestEntity.statusImage,
        statusType: statusAddRequestEntity.statusType,
        stausMessage: statusAddRequestEntity.stausMessage));
  }
}

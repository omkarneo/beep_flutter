import 'dart:io';

import 'package:chat_app/shared/upload/data/data_source/profile_upload_ds.dart';
import 'package:chat_app/shared/upload/domain/entity/profile_upload_response_entity.dart';
import 'package:chat_app/shared/upload/domain/repo/profile_photo_upload_repo.dart';

class ProfilePhotoUploadRepoImpl extends PhotoUploadRepo {
  final UploadPhotoSource uploadPhotoSource;
  ProfilePhotoUploadRepoImpl({required this.uploadPhotoSource});
  @override
  Future<ProfileUploadEntity> uploadPhoto(File file, String useCase) {
    return uploadPhotoSource.uploadApiCall(file, useCase);
  }
}

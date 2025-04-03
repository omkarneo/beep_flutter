import 'dart:io';
import 'package:beep/shared/upload/domain/entity/profile_upload_response_entity.dart';

abstract class PhotoUploadRepo {
  Future<ProfileUploadEntity> uploadPhoto(File file, String useCase);
}

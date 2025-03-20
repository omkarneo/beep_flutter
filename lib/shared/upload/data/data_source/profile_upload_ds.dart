import 'dart:io';

import 'package:chat_app/di/di.dart';
import 'package:chat_app/shared/upload/data/model/profile_upload_response_model.dart';
import 'package:chat_app/utils/constants/url_constants.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/network/base_network_request.dart';
import 'package:chat_app/utils/network/connection.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UploadPhotoSource {
  Future<ProfileUploadModel> uploadApiCall(File file, String usecase) async {
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    final String authToken = sharedPrefs.getauthToken;
    FormData body = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: basename(file.path),
      ),
    });
    var resp = await requestObj.sendRequest(
        method: "FORMPOST",
        headers: {
          "Authorization": "Bearer $authToken",
          'Content-Type': 'multipart/form-data'
        },
        url: usecase == "profile"
            ? profileUploadUrl
            : usecase == "chats"
                ? chatUploadUrl
                : statusUploadUrl,
        body: body,
        fromJson: (data) => ProfileUploadModel.fromJson(data));
    return resp;
  }
}

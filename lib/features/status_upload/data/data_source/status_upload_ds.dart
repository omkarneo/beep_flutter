import 'dart:io';

import 'package:beep/di/di.dart';
import 'package:beep/features/status_upload/data/model/add_status_request_model.dart';
import 'package:beep/features/status_upload/data/model/add_status_response_model.dart';
import 'package:beep/shared/upload/data/model/profile_upload_response_model.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UploadStatusSource {
  Future<StatusAddResponsetModel> createStatusApiCall(
      StatusAddRequestModel statusAddRequestModel) async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "POST",
        url: createstatusUrl,
        body: statusAddRequestModel.toJson(),
        fromJson: (data) => StatusAddResponsetModel.fromJson(data));
    return resp;
  }

  Future<ProfileUploadModel> uploadApiCall(File file) async {
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
        url: statusUploadUrl,
        body: body,
        fromJson: (data) => ProfileUploadModel.fromJson(data));
    return resp;
  }
}

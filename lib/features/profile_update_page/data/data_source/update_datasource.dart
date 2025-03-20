import 'package:chat_app/di/di.dart';
import 'package:chat_app/features/profile_update_page/data/model/update_request_model.dart';
import 'package:chat_app/features/profile_update_page/data/model/update_respose_model.dart';
import 'package:chat_app/utils/constants/url_constants.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/network/base_network_request.dart';
import 'package:chat_app/utils/network/connection.dart';

class ProfileDataSource {
  Future<ProfileUpdateResponseModel> entryApiCall(
      ProfileUpdateRequesModel profileUpdateRequesModel) async {
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    final String? authToken = await sharedPrefs.getauthToken;
    var resp = await requestObj.sendRequest(
        method: "POST",
        headers: {"Authorization": "Bearer $authToken"},
        url: profileUpdateUrl,
        body: profileUpdateRequesModel.toJson(),
        fromJson: (data) => ProfileUpdateResponseModel.fromJson(data));
    return resp;
  }
}

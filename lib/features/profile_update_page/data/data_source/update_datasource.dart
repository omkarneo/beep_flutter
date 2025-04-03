import 'package:beep/di/di.dart';
import 'package:beep/features/profile_update_page/data/model/update_request_model.dart';
import 'package:beep/features/profile_update_page/data/model/update_respose_model.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';

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

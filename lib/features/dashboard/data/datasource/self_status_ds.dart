import 'package:beep/di/di.dart';
import 'package:beep/features/dashboard/data/model/get_self_status_reponse.dart';
import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';

class SelfStatusDs {
  Future<SelfStatusResponeModel> statusApiCall() async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "GET",
        url: getSelfStatusUrl,
        body: null,
        fromJson: (data) => SelfStatusResponeModel.fromJson(data));
    return resp;
  }
}

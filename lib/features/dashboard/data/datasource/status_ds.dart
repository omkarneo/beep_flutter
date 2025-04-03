import 'package:beep/di/di.dart';
import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';

class StatusDataSource {
  Future<StatusResponeModel> statusApiCall() async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "GET",
        url: getDataStatusUrl,
        body: null,
        fromJson: (data) => StatusResponeModel.fromJson(data));
    return resp;
  }
}

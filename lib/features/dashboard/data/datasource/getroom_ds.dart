import 'package:chat_app/di/di.dart';
import 'package:chat_app/features/dashboard/data/model/room_model.dart';
import 'package:chat_app/utils/constants/url_constants.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/network/base_network_request.dart';
import 'package:chat_app/utils/network/connection.dart';

class RoomGetDataSource {
  Future<RoomResponseModel> roomApiCall() async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "GET",
        url: getRoomUrl,
        body: null,
        fromJson: (data) => RoomResponseModel.fromJson(data));
    return resp;
  }
}

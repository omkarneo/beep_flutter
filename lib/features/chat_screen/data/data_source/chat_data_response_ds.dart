import 'package:chat_app/di/di.dart';
import 'package:chat_app/features/chat_screen/data/model/chat_data_response_model.dart';
import 'package:chat_app/utils/constants/url_constants.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/network/base_network_request.dart';
import 'package:chat_app/utils/network/connection.dart';

class ChatDataResponseDs {
  Future<ChatRoomResponseModel> roomApiCall(String roomid) async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "POST",
        url: getChatUrl,
        body: {"roomid": roomid},
        fromJson: (data) => ChatRoomResponseModel.fromJson(data));
    return resp;
  }

  Future<ChatRoomResponseModel> getStatusApiCall(String userid) async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "POST",
        url: getStatusUrl,
        body: {"recevierid": userid},
        fromJson: (data) => ChatRoomResponseModel.fromJson(data));
    return resp;
  }
}

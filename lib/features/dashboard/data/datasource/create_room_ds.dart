import 'package:beep/di/di.dart';
import 'package:beep/features/dashboard/data/model/create_room_reponse_model.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';

class CreateRoomDataSource {
  Future<CreateRoomResponseModel> roomApiCall(String receiverUserId) async {
    Map<String, dynamic> header = {
      "Authorization": "Bearer ${sharedPrefs.getauthToken}"
    };
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        headers: header,
        method: "POST",
        url: createRoomUrl,
        body: {"receiverUserId": receiverUserId},
        fromJson: (data) => CreateRoomResponseModel.fromJson(data));
    return resp;
  }
}

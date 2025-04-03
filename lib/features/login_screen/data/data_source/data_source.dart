// import 'package:beep/di/di.dart';
// import 'package:beep/features/login_screen/data/model/model.dart';
// import 'package:beep/features/login_screen/data/model/request_model.dart';
// import 'package:beep/utils/constants/url_constants.dart';
// import 'package:beep/utils/network/base_network_request.dart';
// import 'package:beep/utils/network/connection.dart';

// class LoginDataSource {
//   Future<ResponseModel> loginDataSource(RequestModel resquestData) async {
//     const authToken = "";
//     NetworkRequest requestObj =
//         NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
//     var resp = await requestObj.sendRequest(
//         method: "PUT",
//         url: entryUrl,
//         body: resquestData.toJson(),
//         headers: {"Authorization": "Bearer $authToken"},
//         fromJson: (data) => ResponseModel.fromJson(data));
//     return resp;
//   }
// }

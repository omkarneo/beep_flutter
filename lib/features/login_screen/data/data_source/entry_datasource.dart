import 'package:beep/di/di.dart';
import 'package:beep/features/login_screen/data/model/request_entry_model.dart';
import 'package:beep/features/login_screen/data/model/response_entry_model.dart';
import 'package:beep/features/login_screen/data/model/response_otp_model.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';

class EntryDataSource {
  Future<EntryResponseModel> entryApiCall(
      EntryRequestModel resquestData) async {
    print("In datasource ${resquestData.phonenumber} ");
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());

    var resp = await requestObj.sendRequest(
        method: "POST",
        url: entryUrl,
        body: resquestData.toJson(),
        fromJson: (data) => EntryResponseModel.fromJson(data));
    return resp;
  }

  Future<OtpResponseModel> otpVerifyApiCall(
      OtpRequestModel resquestData) async {
    print("In datasource ${resquestData.toJson()} ${resquestData.otp} ");
    NetworkRequest requestObj =
        NetworkRequest(networkInfo: locator<NetworkInfoImpl>());
    var resp = await requestObj.sendRequest(
        method: "POST",
        url: otpVerifyUrl,
        body: {"otp": "1234", "number": resquestData.phonenumber},
        fromJson: (data) => OtpResponseModel.fromJson(data));
    return resp;
  }
}

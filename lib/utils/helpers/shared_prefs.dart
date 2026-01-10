import 'package:beep/utils/helpers/base_url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  //  =======KEYS========
  static const String authTokenKey = "authToken";

  static const String firstLoginKey = "firstLogin";
  static const String statusKey = "statusKey";

  static const String id = "userid";
  static const String name = "usernameKey";
  static const String userPhoto = "userPhoto";
  //  =======Getters=====
  String get getid => _sharedPrefs!.getString(id) ?? "";
  String get getname => _sharedPrefs!.getString(name) ?? "";
  String get getstatusKey => _sharedPrefs!.getString(statusKey) ?? "";
  String get getauthToken => _sharedPrefs!.getString(authTokenKey) ?? "";
  String get getfirstLogin => _sharedPrefs!.getString(firstLoginKey) ?? "";
  String get getuserPhoto => _sharedPrefs!.getString(userPhoto) ?? "";
  //  =======Setters=====
  setid(String userid) async {
    await _sharedPrefs!.setString(id, userid);
  }

  setuserPhoto(String data) async {
    await _sharedPrefs!.setString(userPhoto, "${AppUrl.baseUrl}$data");
  }

  setname(String data) async {
    await _sharedPrefs!.setString(name, data);
  }

  setstatusKey(String data) async {
    await _sharedPrefs!.setString(statusKey, data);
  }

  setAuthToken(String authToken) async {
    await _sharedPrefs!.setString(authTokenKey, authToken);
  }

  setAuthfirstLoginKey(bool data) async {
    await _sharedPrefs!.setString(firstLoginKey, data.toString());
  }

  logout() {
    _sharedPrefs!.remove(authTokenKey);
    _sharedPrefs!.remove(id);
    _sharedPrefs!.remove(name);
  }
}

final sharedPrefs = SharedPrefs();

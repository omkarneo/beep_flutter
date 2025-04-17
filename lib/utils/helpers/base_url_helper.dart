import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/env_helper.dart';

class AppUrl {
  static String baseUrl =
      envHelper.forProd() == true ? baseProdUrl : baseDevUrl;
}

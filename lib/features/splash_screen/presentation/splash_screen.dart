import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/helpers/socket_helper.dart';
import 'package:chat_app/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/constants/color_constants.dart';
import 'package:chat_app/utils/theme/text_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        "get token ${sharedPrefs.getauthToken} ${sharedPrefs.getauthToken.runtimeType}");
    Future.delayed(Duration(seconds: 3), () async {
      if (sharedPrefs.getfirstLogin == "false") {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.Onboarding,
          (route) => false,
        );
      } else {
        if (sharedPrefs.getauthToken.isEmpty) {
          await Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else {
          sharedPrefs.setstatusKey("Online");
          SocketHelper.loginWithid(sharedPrefs.getid ?? "");
          await Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboardScreen,
            (route) => false,
          );
        }
      }
    });
    return Scaffold(
        backgroundColor: primaryBackground,
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BEEP",
                style: TextStyleHelper.boldStyle(
                    fontSize: 36, color: primaryTextColor),
              )
            ],
          ),
          // child: SvgPicture.asset(splashBackground,fit: BoxFit.fill,height: MediaQuery.sizeOf(context).height,width: MediaQuery.sizeOf(context).width,semanticsLabel: 'My SVG Picture'  ))
        ));
  }
}

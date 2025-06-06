import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:beep/di/di.dart';
import 'package:beep/features/no_internet_page/presentation/no_internet_page.dart';
import 'package:beep/utils/helpers/notification_helper.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:beep/utils/router/router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/theme/text_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async {
      var connectivity = await locator<Connectivity>().checkConnectivity();
      print(connectivity);
      if (connectivity.contains(ConnectivityResult.mobile) ||
          connectivity.contains(ConnectivityResult.wifi) ||
          connectivity.contains(ConnectivityResult.ethernet)) {
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
            SocketHelper.loginWithid();
            await Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboardScreen,
              arguments: 0,
              (route) => false,
            );
          }
        }
      } else {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoInternetPage(),
            ));
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

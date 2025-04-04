import 'package:camera/camera.dart';
import 'package:beep/features/camera/presentation/camera_page.dart';
import 'package:beep/features/dashboard/presentation/dashboard.dart';
import 'package:beep/features/chat_screen/presentation/chat_screen.dart';
import 'package:beep/features/login_screen/presentation/login_screen.dart';
import 'package:beep/features/onboarding_screen/presentation/onboarding_screen.dart';
import 'package:beep/features/profile_update_page/presentation/profile_update_page.dart';
import 'package:beep/features/status_upload/presentation/status_upload.dart';
import 'package:beep/features/status_viewer/presentation/status_viewer.dart';
import 'package:beep/utils/router/arguments/camera_page_argument.dart';
import 'package:beep/utils/router/arguments/chatscreen_argymenjt.dart';
import 'package:beep/utils/router/arguments/status_preview_argument.dart';
import 'package:beep/utils/router/arguments/status_upload_page_arg.dart';
import 'package:flutter/material.dart';
import 'package:beep/features/splash_screen/presentation/splash_screen.dart';

class AppRoutes {
  /// AppRouter - All the Screen/Pages in the app will be added here in this Map.
  static const root = '/';
  static const login = "/login";
  static const Onboarding = "/onboarding";
  static const dashboardScreen = "/dashboardscreen";
  static const profileUpdate = "/profileupdate";
  static const chatScreen = "/chatScreen";
  static const statusPreviewScreen = "/statusPreviewScreen";
  static const cameraScreen = "/cameraScreen";
  static const statusuploadpage = "/statusuploadpage";
}

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.Onboarding:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OnBoardingScreen(),
          settings: settings,
        );
      case AppRoutes.dashboardScreen:
        int? tab = arguments as int;
        return MaterialPageRoute<dynamic>(
          builder: (_) => DashboardScreen(
            lastindex: tab,
          ),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.chatScreen:
        ChatscreenArgument? args = arguments as ChatscreenArgument;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChatScreen(
            roomid: args.roomid,
            phonenumber: args.phonenumber,
            name: args.name,
            photos: args.photo,
            receiverId: args.receiverId,
          ),
          settings: settings,
        );
      case AppRoutes.profileUpdate:
        String? args = arguments as String;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ProfileUpdatePage(
            phoneNumber: args,
          ),
          settings: settings,
        );
      case AppRoutes.statusPreviewScreen:
        StatusPreviewArgument? args = arguments as StatusPreviewArgument;
        return MaterialPageRoute<dynamic>(
          builder: (_) => StatusViewer(
            // image: args,
            index: args.index,
            statusList: args.statusList,
          ),
          settings: settings,
        );
      case AppRoutes.cameraScreen:
        CameraPageArgument? args = arguments as CameraPageArgument;
        return MaterialPageRoute<dynamic>(
          builder: (_) => CameraPage(
            cameras: args.cameras,
            fromchatScreen: args.fromchatScreen,
          ),
          settings: settings,
        );
      case AppRoutes.statusuploadpage:
        StatusUploadPageArg? args = arguments as StatusUploadPageArg;
        return MaterialPageRoute<dynamic>(
          builder: (_) => StatusUploadPage(
            image: args.image,
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const Material(
              child: Center(
                  child: Text(
                      "Implementation of Custom Error page for unknown route as a separate stateless widget"))),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}

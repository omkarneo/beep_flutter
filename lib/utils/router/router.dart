import 'package:chat_app/features/dashboard/presentation/dashboard.dart';
import 'package:chat_app/features/chat_screen/presentation/chat_screen.dart';
import 'package:chat_app/features/login_screen/presentation/login_screen.dart';
import 'package:chat_app/features/onboarding_screen/presentation/onboarding_screen.dart';
import 'package:chat_app/features/profile_update_page/presentation/profile_update_page.dart';
import 'package:chat_app/utils/router/arguments/chatscreen_argymenjt.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/splash_screen/presentation/splash_screen.dart';

class AppRoutes {
  /// AppRouter - All the Screen/Pages in the app will be added here in this Map.
  static const root = '/';
  static const login = "/login";
  static const Onboarding = "/onboarding";
  static const dashboardScreen = "/dashboardscreen";
  static const profileUpdate = "/profileupdate";
  static const chatScreen = "/chatScreen";
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
        return MaterialPageRoute<dynamic>(
          builder: (_) => const DashboardScreen(),
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

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:beep/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:beep/features/chat_screen/presentation/bloc/chat_send_bloc.dart';
import 'package:beep/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/features/dashboard/domain/usecase/create_room_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/get_post_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getuser_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/profile_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/self_status_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/status_get_usecase.dart';
import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/features/login_screen/domain/usecase/entry_usecase.dart';
import 'package:beep/features/profile_update_page/domain/usecase/update_usecase.dart';
import 'package:beep/features/profile_update_page/presentation/bloc/update_profile_bloc.dart';
import 'package:beep/features/status_upload/domain/usecase/status_create_usecase.dart';
import 'package:beep/features/status_upload/domain/usecase/status_upload_usecase.dart';
import 'package:beep/features/status_upload/presentation/bloc/status_upload_bloc.dart';
import 'package:beep/firebase_options.dart';
import 'package:beep/shared/upload/domain/usecase/chat_photo_upload_usecase.dart';
import 'package:beep/shared/upload/domain/usecase/profile_photo_upload_usecase.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/helpers/env_helper.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beep/di/di.dart';
import 'package:beep/features/login_screen/presentation/bloc/login_screen_bloc.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/app_theme.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 10,
    payload: {"roomid": message.data['roomid']},
    channelKey: 'MESSAGE_CHANNEL',
    actionType: ActionType.Default,
    title: message.notification!.title,
    body: message.notification?.body ?? "",
  ));
  print(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await envHelper.load(fileName: ".env");
  await initializeDependencies();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: SystemUiOverlay.values,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_stat_name',
      [
        NotificationChannel(
            channelGroupKey: 'MESSAGE_CHANNEL',
            channelKey: 'MESSAGE_CHANNEL',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: primaryBackground,
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'MESSAGE_CHANNEL', channelGroupName: 'Basic group')
      ],
      debug: true);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
  }
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      payload: {"roomid": message.data['roomid']},
      channelKey: 'MESSAGE_CHANNEL',
      actionType: ActionType.Default,
      title: message.notification!.title,
      body: message.notification?.body ?? "",
    ));
  });
  FirebaseMessaging.onMessageOpenedApp.listen((data) {
    print(data);
    print("Message clicked!");
  });

  await sharedPrefs.init();
  SocketHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      SocketHelper.logoutwithid();
    } else if (state == AppLifecycleState.resumed) {
      SocketHelper.loginWithid();
    } else if (state == AppLifecycleState.inactive) {
      SocketHelper.logoutwithid();
    } else if (state == AppLifecycleState.detached) {
      SocketHelper.logoutwithid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginScreenBloc(
              entryUseCase: locator<EntryUseCase>(),
              otpVerifyUse: locator<OtpVerifyUse>()),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(
              profilePhotoUploadUsecase: locator<ProfilePhotoUploadUsecase>(),
              profileUpdateUseCase: locator<ProfileUpdateUseCase>()),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(
              getPostUsecase: locator<GetPostUsecase>(),
              statusGetUsecase: locator<StatusGetUsecase>(),
              createRoomUsecase: locator<CreateRoomUsecase>(),
              getProfileData: locator<GetProfileData>(),
              getRoomDataUseCase: locator<GetRoomDataUseCase>(),
              getUserData: locator<GetUserData>(),
              selfStatusUsecase: locator<SelfStatusUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              StatusBloc(getUserStatusUsecase: locator<GetUserStatusUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              ChatRoomBloc(chatRoomDataUsecase: locator<ChatRoomDataUsecase>()),
        ),
        BlocProvider(
          create: (context) => ChatSendBloc(
              chatPhotoUploadUsecase: locator<ChatPhotoUploadUsecase>()),
        ),
        BlocProvider(
          create: (context) => StatusUploadBloc(
            statusCreateUsecase: locator<StatusCreateUsecase>(),
            statusUploadUsecase: locator<StatusUploadUsecase>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          themeMode: ThemeMode.dark,
          navigatorKey: AppRouter.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: "Beep",
          onGenerateRoute: (settings) =>
              locator<AppRouter>().onGenerateRoute(settings),
          initialRoute: AppRoutes.root,
          theme: AppTheme.lightTheme,
          // themeMode: theme,
        ),
      ),
    );
  }
}

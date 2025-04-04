import 'dart:io';

import 'package:beep/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:beep/features/chat_screen/presentation/bloc/chat_send_bloc.dart';
import 'package:beep/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/features/dashboard/domain/usecase/create_room_usecase.dart';
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
import 'package:beep/shared/upload/domain/usecase/chat_photo_upload_usecase.dart';
import 'package:beep/shared/upload/domain/usecase/profile_photo_upload_usecase.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beep/di/di.dart';
import 'package:beep/features/login_screen/presentation/bloc/login_screen_bloc.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
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
    WidgetsBinding.instance.addObserver(this);
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

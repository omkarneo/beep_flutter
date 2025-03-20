import 'dart:io';

import 'package:chat_app/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:chat_app/features/chat_screen/presentation/bloc/chat_send_bloc.dart';
import 'package:chat_app/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:chat_app/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:chat_app/features/dashboard/domain/usecase/create_room_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/getuser_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/profile_usecase.dart';
import 'package:chat_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:chat_app/features/login_screen/domain/usecase/entry_usecase.dart';
import 'package:chat_app/features/profile_update_page/domain/usecase/update_usecase.dart';
import 'package:chat_app/features/profile_update_page/presentation/bloc/update_profile_bloc.dart';
import 'package:chat_app/shared/upload/domain/usecase/chat_photo_upload_usecase.dart';
import 'package:chat_app/shared/upload/domain/usecase/profile_photo_upload_usecase.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/helpers/socket_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/di/di.dart';
import 'package:chat_app/features/login_screen/domain/usecase/login_usecase.dart';
import 'package:chat_app/features/login_screen/presentation/bloc/login_screen_bloc.dart';
import 'package:chat_app/utils/router/router.dart';
import 'package:chat_app/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await sharedPrefs.init();
  SocketHelper.init();
  // SocketHelper.statusSocket();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
              createRoomUsecase: locator<CreateRoomUsecase>(),
              getProfileData: locator<GetProfileData>(),
              getRoomDataUseCase: locator<GetRoomDataUseCase>(),
              getUserData: locator<GetUserData>()),
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: "Sbi Interview",
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

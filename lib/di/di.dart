import 'package:beep/features/chat_screen/data/data_source/chat_data_response_ds.dart';
import 'package:beep/features/chat_screen/data/repo_lmpl/chat_data_repo_impl.dart';
import 'package:beep/features/chat_screen/domain/repo/chat_data_repo.dart';
import 'package:beep/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:beep/features/dashboard/data/datasource/create_room_ds.dart';
import 'package:beep/features/dashboard/data/datasource/get_post_ds.dart';
import 'package:beep/features/dashboard/data/datasource/getroom_ds.dart';
import 'package:beep/features/dashboard/data/datasource/profile_ds.dart';
import 'package:beep/features/dashboard/data/datasource/search_ds.dart';
import 'package:beep/features/dashboard/data/datasource/self_status_ds.dart';
import 'package:beep/features/dashboard/data/datasource/status_ds.dart';
import 'package:beep/features/dashboard/data/repo_implentation/create_repo_impl.dart';
import 'package:beep/features/dashboard/data/repo_implentation/post_repo_impl.dart';
import 'package:beep/features/dashboard/data/repo_implentation/profile_repo_impl.dart';
import 'package:beep/features/dashboard/data/repo_implentation/room_repo_imple.dart';
import 'package:beep/features/dashboard/data/repo_implentation/search_repo_impl.dart';
import 'package:beep/features/dashboard/data/repo_implentation/self_status_repo_imple.dart';
import 'package:beep/features/dashboard/data/repo_implentation/status_repo_imple.dart';
import 'package:beep/features/dashboard/domain/repo/create_room_repo.dart';
import 'package:beep/features/dashboard/domain/repo/post_repo.dart';
import 'package:beep/features/dashboard/domain/repo/profile_repo.dart';
import 'package:beep/features/dashboard/domain/repo/room_repo.dart';
import 'package:beep/features/dashboard/domain/repo/search_repo.dart';
import 'package:beep/features/dashboard/domain/repo/self_status_repo.dart';
import 'package:beep/features/dashboard/domain/repo/status_repo.dart';
import 'package:beep/features/dashboard/domain/usecase/create_room_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/get_post_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getuser_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/profile_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/self_status_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/status_get_usecase.dart';
import 'package:beep/features/login_screen/data/data_source/entry_datasource.dart';
import 'package:beep/features/login_screen/data/repository_impl/entry_repo_imple.dart';
import 'package:beep/features/login_screen/domain/repository/entry_repo.dart';
import 'package:beep/features/login_screen/domain/usecase/entry_usecase.dart';
import 'package:beep/features/profile_update_page/data/data_source/update_datasource.dart';
import 'package:beep/features/profile_update_page/data/repo_impl/update_repo_impl.dart';
import 'package:beep/features/profile_update_page/domain/repo/update_repo.dart';
import 'package:beep/features/profile_update_page/domain/usecase/update_usecase.dart';
import 'package:beep/features/status_upload/data/data_source/status_upload_ds.dart';
import 'package:beep/features/status_upload/data/repo_imple/status_upload_repo_impl.dart';
import 'package:beep/features/status_upload/domain/repo/status_photo_upload.dart';
import 'package:beep/features/status_upload/domain/usecase/status_create_usecase.dart';
import 'package:beep/features/status_upload/domain/usecase/status_upload_usecase.dart';
import 'package:beep/shared/upload/data/data_source/profile_upload_ds.dart';
import 'package:beep/shared/upload/data/repo_imple/profile_photo_upload_repo_impl.dart';
import 'package:beep/shared/upload/domain/repo/profile_photo_upload_repo.dart';
import 'package:beep/shared/upload/domain/usecase/chat_photo_upload_usecase.dart';
import 'package:beep/shared/upload/domain/usecase/profile_photo_upload_usecase.dart';
import 'package:beep/shared/upload/domain/usecase/status_photo_upload_usecase.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:beep/utils/network/base_network_request.dart';
import 'package:beep/utils/network/connection.dart';
import 'package:beep/utils/router/router.dart';

final GetIt locator = GetIt.instance;
Future<void> initializeDependencies() async {
/*
::::::::::::::::::::::::::::::::::::::::::::::::::::::
     :::::::::::::::: USE CASES :::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::
 */
  locator.registerLazySingleton<GetPostUsecase>(
    () => GetPostUsecase(postRepo: locator<PostRepo>()),
  );
  locator.registerLazySingleton<StatusCreateUsecase>(
    () => StatusCreateUsecase(
        statusPhotoUpload: locator<StatusPhotoRepoUpload>()),
  );
  locator.registerLazySingleton<StatusUploadUsecase>(
    () => StatusUploadUsecase(
        statusPhotoUpload: locator<StatusPhotoRepoUpload>()),
  );
  locator.registerLazySingleton<SelfStatusUsecase>(
    () => SelfStatusUsecase(selfStatusRepo: locator<SelfStatusRepo>()),
  );
  locator.registerLazySingleton<StatusGetUsecase>(
    () => StatusGetUsecase(statusRepo: locator<StatusRepo>()),
  );
  locator.registerLazySingleton<ChatPhotoUploadUsecase>(
    () => ChatPhotoUploadUsecase(photoUploadRepo: locator<PhotoUploadRepo>()),
  );
  locator.registerLazySingleton<ProfilePhotoUploadUsecase>(
    () =>
        ProfilePhotoUploadUsecase(photoUploadRepo: locator<PhotoUploadRepo>()),
  );
  locator.registerLazySingleton<StatusPhotoUploadUsecase>(
    () => StatusPhotoUploadUsecase(photoUploadRepo: locator<PhotoUploadRepo>()),
  );
  locator.registerLazySingleton<ChatRoomDataUsecase>(
    () => ChatRoomDataUsecase(chatDataRepo: locator<ChatDataRepo>()),
  );
  locator.registerLazySingleton<GetUserStatusUsecase>(
    () => GetUserStatusUsecase(chatDataRepo: locator<ChatDataRepo>()),
  );
  locator.registerLazySingleton<CreateRoomUsecase>(
    () => CreateRoomUsecase(createRoomRepo: locator<CreateRoomRepo>()),
  );
  locator.registerLazySingleton<GetUserData>(
    () => GetUserData(searchRepo: locator<SearchRepo>()),
  );
  locator.registerLazySingleton<GetRoomDataUseCase>(
    () => GetRoomDataUseCase(getRoomRepo: locator<GetRoomRepo>()),
  );
  locator.registerLazySingleton<GetProfileData>(
    () => GetProfileData(profileRepo: locator<ProfileRepo>()),
  );
  locator.registerLazySingleton<OtpVerifyUse>(
    () => OtpVerifyUse(entryRepo: locator<EntryRepo>()),
  );
  locator.registerLazySingleton<EntryUseCase>(
    () => EntryUseCase(entryRepo: locator<EntryRepo>()),
  );
  locator.registerLazySingleton<ProfileUpdateUseCase>(
    () => ProfileUpdateUseCase(updateRepo: locator<UpdateRepo>()),
  );
/*
:::::::::::::::::::::::::::::::::::::::::::::::::::::
    :::::::::::::::  REPOSITORIES ::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
 */
  locator.registerLazySingleton<PostRepo>(
      () => PostRepoImpl(getPostDataSource: locator<GetPostDataSource>()));
  locator.registerLazySingleton<StatusPhotoRepoUpload>(() =>
      StatusUploadRepoImpl(uploadStatusSource: locator<UploadStatusSource>()));
  locator.registerLazySingleton<SelfStatusRepo>(
      () => SelfStatusRepoImple(selfStatusDs: locator<SelfStatusDs>()));
  locator.registerLazySingleton<StatusRepo>(
      () => StatusRepoImple(statusDataSource: locator<StatusDataSource>()));
  locator.registerLazySingleton<PhotoUploadRepo>(() =>
      ProfilePhotoUploadRepoImpl(
          uploadPhotoSource: locator<UploadPhotoSource>()));
  locator.registerLazySingleton<ChatDataRepo>(() =>
      ChatDataRepoImpl(chatDataResponseDs: locator<ChatDataResponseDs>()));

  locator.registerLazySingleton<CreateRoomRepo>(() =>
      CreateRepoImpl(createRoomDataSource: locator<CreateRoomDataSource>()));

  locator.registerLazySingleton<SearchRepo>(
      () => SearchRepoImpl(searchDataSource: locator<SearchDataSource>()));

  locator.registerLazySingleton<ProfileRepo>(() =>
      ProfileRepoImpl(profileGetDataSource: locator<ProfileGetDataSource>()));

  locator.registerLazySingleton<GetRoomRepo>(
      () => RoomRepoImple(roomGetDataSource: locator<RoomGetDataSource>()));

  locator.registerLazySingleton<EntryRepo>(
      () => EntryRepoImple(entryDataSource: locator<EntryDataSource>()));

  locator.registerLazySingleton<UpdateRepo>(
      () => UpdateRepoImpl(profileDataSource: locator<ProfileDataSource>()));
  /*
:::::::::::::::::::::::::::::::::::::::::::::::::::::
    :::::::::::::::  DATA SOURCE ::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
*/
  locator.registerLazySingleton<GetPostDataSource>(
    () => GetPostDataSource(),
  );
  locator.registerLazySingleton<UploadStatusSource>(
    () => UploadStatusSource(),
  );
  locator.registerLazySingleton<SelfStatusDs>(
    () => SelfStatusDs(),
  );
  locator.registerLazySingleton<StatusDataSource>(
    () => StatusDataSource(),
  );
  locator.registerLazySingleton<UploadPhotoSource>(
    () => UploadPhotoSource(),
  );
  locator.registerLazySingleton<ChatDataResponseDs>(
    () => ChatDataResponseDs(),
  );
  locator.registerLazySingleton<CreateRoomDataSource>(
    () => CreateRoomDataSource(),
  );
  locator.registerLazySingleton<SearchDataSource>(
    () => SearchDataSource(),
  );
  locator.registerLazySingleton<RoomGetDataSource>(
    () => RoomGetDataSource(),
  );
  locator.registerLazySingleton<ProfileGetDataSource>(
    () => ProfileGetDataSource(),
  );
  locator.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSource(),
  );
  locator.registerLazySingleton<EntryDataSource>(
    () => EntryDataSource(),
  );
/*

:::::::::::::::::::::::::::::::::::::::::::::::::::::
    :::::::::::::::  NETWORK UTILS ::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
*/

  locator.registerFactory<NetworkInfoImpl>(() => NetworkInfoImpl(
        connectivity: locator.call(), //Connectivity_plus removed
      ));

  locator.registerFactory<NetworkRequest>(() => NetworkRequest(
        networkInfo: locator.call(),
      ));

  final Connectivity connectivityResult = await Connectivity();

  locator.registerLazySingleton(() => connectivityResult);
  locator.registerSingleton<AppRouter>(AppRouter());
}

import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:beep/features/dashboard/data/model/room_model.dart';
import 'package:beep/features/dashboard/data/model/search_model.dart';
import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:beep/features/dashboard/domain/entity/profile_entity.dart';
import 'package:beep/features/dashboard/domain/usecase/create_room_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/getuser_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/profile_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/self_status_usecase.dart';
import 'package:beep/features/dashboard/domain/usecase/status_get_usecase.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetRoomDataUseCase getRoomDataUseCase;
  final GetProfileData getProfileData;
  final GetUserData getUserData;
  final CreateRoomUsecase createRoomUsecase;
  final StatusGetUsecase statusGetUsecase;
  final SelfStatusUsecase selfStatusUsecase;

  DashboardBloc(
      {required this.getProfileData,
      required this.getRoomDataUseCase,
      required this.getUserData,
      required this.createRoomUsecase,
      required this.statusGetUsecase,
      required this.selfStatusUsecase})
      : super(DashboardInitial()) {
    on<DashboardProfileEvent>((event, emit) async {
      try {
        var response = await getProfileData.call(params: "");
        emit(DashboardProfileState(profileResponseEntity: response));
      } catch (err) {}
    });
    on<DashboardCallEvent>(
      (event, emit) async {
        try {
          var statusresponse = await statusGetUsecase.call(params: "");
          var selfstatusresponse = await selfStatusUsecase.call(params: "");
          if (selfstatusresponse.message == "no status found") {
            emit(DashboardCallState(
                photo: selfstatusresponse.data!.userphotos!,
                username: selfstatusresponse.data!.username!,
                statusData: statusresponse.data!,
                selfStatus: null));
          } else {
            emit(DashboardCallState(
                photo: selfstatusresponse.data!.userphotos!,
                username: selfstatusresponse.data!.username!,
                statusData: statusresponse.data!,
                selfStatus: selfstatusresponse.data!.statusdata));
          }
        } catch (err) {}
      },
    );
    on<DashboardChatEvent>((event, emit) async {
      try {
        var response = await getRoomDataUseCase.call(params: "");
        var statusresponse = await statusGetUsecase.call(params: "");
        emit(DashboardChatState(
            roomData: response.data, statusData: statusresponse.data));
      } catch (err) {}
    });
    on<DashboardSearchEvent>((event, emit) async {
      try {
        var response = await getUserData.call(params: "");
        emit(DashboardSearchState(
          data: response.data,
        ));
      } catch (err) {}
    });
    on<DashboardCreateRoomEvent>((event, emit) async {
      try {
        var oldState = (state as DashboardSearchState);
        CreateRoomResponseEntity response =
            await createRoomUsecase.call(params: event.receiverid);

        print("search page bloc ${response.roomid} $response");
        if (response.message == "Room Created") {
          print("search page ${response.roomid}");
          emit(DashboardSearchState(
              data: oldState.data,
              roomid: response.roomid!,
              phonenumber: oldState.data?[event.index].phonenumber,
              photos: oldState.data?[event.index].photos,
              receiverId: oldState.data?[event.index].id,
              name:
                  "${oldState.data?[event.index].firstName} ${oldState.data?[event.index].lastName}"));
        } else {
          print("search page ${response.roomid}");
          emit(DashboardSearchState(
              photos: oldState.data?[event.index].photos,
              phonenumber: oldState.data?[event.index].phonenumber,
              receiverId: oldState.data?[event.index].id,
              name:
                  "${oldState.data?[event.index].firstName} ${oldState.data?[event.index].lastName}",
              data: oldState.data,
              roomid: response.roomid!));
        }
      } catch (err) {}
    });
  }
}

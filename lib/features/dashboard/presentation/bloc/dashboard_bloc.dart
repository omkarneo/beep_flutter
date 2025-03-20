import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/dashboard/data/model/room_model.dart';
import 'package:chat_app/features/dashboard/data/model/search_model.dart';
import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:chat_app/features/dashboard/domain/entity/profile_entity.dart';
import 'package:chat_app/features/dashboard/domain/usecase/create_room_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/getroom_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/getuser_usecase.dart';
import 'package:chat_app/features/dashboard/domain/usecase/profile_usecase.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetRoomDataUseCase getRoomDataUseCase;
  final GetProfileData getProfileData;
  final GetUserData getUserData;
  final CreateRoomUsecase createRoomUsecase;
  DashboardBloc(
      {required this.getProfileData,
      required this.getRoomDataUseCase,
      required this.getUserData,
      required this.createRoomUsecase})
      : super(DashboardInitial()) {
    on<DashboardProfileEvent>((event, emit) async {
      try {
        var response = await getProfileData.call(params: "");
        emit(DashboardProfileState(profileResponseEntity: response));
      } catch (err) {}
    });
    on<DashboardChatEvent>((event, emit) async {
      try {
        var response = await getRoomDataUseCase.call(params: "");
        emit(DashboardChatState(roomData: response.data));
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

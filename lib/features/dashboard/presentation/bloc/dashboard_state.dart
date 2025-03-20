part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

class DashboardCallState extends DashboardState {}

class DashboardSearchState extends DashboardState {
  final List<UserData>? data;

  final String? roomid;
  final String? receiverId;
  final String? name;
  final String? photos;
  final String? phonenumber;
  const DashboardSearchState(
      {required this.data,
      this.receiverId,
      this.roomid,
      this.name,
      this.photos,
      this.phonenumber});
  @override
  List<Object> get props => [data.hashCode, roomid.hashCode];
}

class DashboardProfileState extends DashboardState {
  final ProfileResponseEntity profileResponseEntity;
  const DashboardProfileState({required this.profileResponseEntity});
  @override
  List<Object> get props => [profileResponseEntity];
}

class DashboardChatState extends DashboardState {
  final List<RoomData>? roomData;

  DashboardChatState({required this.roomData});
  @override
  List<Object> get props => [roomData!];
}

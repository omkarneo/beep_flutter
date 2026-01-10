part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

class DashboardCallState extends DashboardState {
  final List<Status> statusData;
  final Status? selfStatus;
  final String username;
  final String photo;
  const DashboardCallState(
      {required this.statusData,
      this.selfStatus,
      required this.photo,
      required this.username});
  @override
  List<Object> get props => [statusData];
}

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
  final List<Status>? statusData;
  final List<RoomData>? roomData;

  const DashboardChatState({required this.roomData, this.statusData});
  @override
  List<Object> get props => [roomData!];
}

class DashboardPostState extends DashboardState {
  final List<PostEnity>? postData;

  const DashboardPostState({required this.postData});
  @override
  List<Object> get props => [postData!];
}

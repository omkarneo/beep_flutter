part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardCallEvent extends DashboardEvent {}

class DashboardSearchEvent extends DashboardEvent {}

class DashboardProfileEvent extends DashboardEvent {}

class DashboardPostEvent extends DashboardEvent {}

class DashboardChatEvent extends DashboardEvent {}

class DashboardCreateRoomEvent extends DashboardEvent {
  final String receiverid;
  final int index;
  const DashboardCreateRoomEvent(
      {required this.receiverid, required this.index});
  List<Object> get props => [receiverid, index];
}

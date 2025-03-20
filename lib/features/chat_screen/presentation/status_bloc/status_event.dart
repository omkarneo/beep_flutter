part of 'status_bloc.dart';

sealed class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

class ReceiverStatusEvent extends StatusEvent {
  final String id;
  final String status;
  const ReceiverStatusEvent({required this.id, required this.status});

  @override
  List<Object> get props => [id, status];
}

class StartStatusSocketEvent extends StatusEvent {
  final String phoneNumber;
  const StartStatusSocketEvent({required this.phoneNumber});
}

class GetUserStatusEvent extends StatusEvent {
  final String receiverId;
  const GetUserStatusEvent({required this.receiverId});
}

class StatusDisconnect extends StatusEvent {}

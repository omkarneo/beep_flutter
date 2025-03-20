part of 'chat_room_bloc.dart';

sealed class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object> get props => [];
}

final class ChatRoomInitial extends ChatRoomState {}

class ChatRoomMessageState extends ChatRoomState {
  final List<ChatRoomMessage> messages;
  const ChatRoomMessageState({required this.messages});
  @override
  List<Object> get props => [messages];
}

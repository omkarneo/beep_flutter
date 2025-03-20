part of 'chat_room_bloc.dart';

sealed class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class JoinChatRoom extends ChatRoomEvent {
  final String roomid;
  const JoinChatRoom({required this.roomid});
}

class SocketGetMessageEvent extends ChatRoomEvent {
  dynamic socketData;
  SocketGetMessageEvent({this.socketData});
}

class ChatroomDisconnect extends ChatRoomEvent {
  final String roomid;
  ChatroomDisconnect({required this.roomid});
}

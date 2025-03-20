part of 'chat_send_bloc.dart';

sealed class ChatSendEvent extends Equatable {
  const ChatSendEvent();

  @override
  List<Object> get props => [];
}

class ChatMediaEvent extends ChatSendEvent {
  final File chatmedia;
  const ChatMediaEvent({required this.chatmedia});
  @override
  List<Object> get props => [];
}

class ChatTextEvent extends ChatSendEvent {}

class SendMessageEvent extends ChatSendEvent {
  final File? chatmedia;
  final String senderid;
  final String message;
  final String roomid;
  const SendMessageEvent(
      {required this.message,
      required this.roomid,
      required this.senderid,
      this.chatmedia});
  @override
  List<Object> get props => [];
}

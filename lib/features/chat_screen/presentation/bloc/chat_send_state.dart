part of 'chat_send_bloc.dart';

sealed class ChatSendState extends Equatable {
  const ChatSendState();

  @override
  List<Object> get props => [];
}

final class ChatSendText extends ChatSendState {}

final class ChatSendMedia extends ChatSendState {
  final File media;
  const ChatSendMedia({required this.media});

  @override
  List<Object> get props => [media];
}

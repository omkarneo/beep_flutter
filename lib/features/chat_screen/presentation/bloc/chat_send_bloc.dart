import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/shared/upload/domain/entity/profile_upload_response_entity.dart';
import 'package:chat_app/shared/upload/domain/usecase/chat_photo_upload_usecase.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/helpers/socket_helper.dart';
import 'package:equatable/equatable.dart';

part 'chat_send_event.dart';
part 'chat_send_state.dart';

class ChatSendBloc extends Bloc<ChatSendEvent, ChatSendState> {
  final ChatPhotoUploadUsecase chatPhotoUploadUsecase;
  ChatSendBloc({required this.chatPhotoUploadUsecase}) : super(ChatSendText()) {
    on<SendMessageEvent>((event, emit) async {
      if (event.chatmedia != null) {
        ProfileUploadEntity response =
            await chatPhotoUploadUsecase.call(params: event.chatmedia);
        SocketHelper.socket.emit("sendMessage", {
          "senderId": sharedPrefs.getid,
          "roomId": event.roomid,
          "message": event.message,
          "messagetype": "image",
          "image": response.fileUrl
        });
      } else {
        SocketHelper.socket.emit("sendMessage", {
          "senderId": sharedPrefs.getid,
          "roomId": event.roomid,
          "message": event.message,
          "messagetype": "text"
        });
      }
      emit(ChatSendText());
    });
    on<ChatMediaEvent>(
      (event, emit) {
        emit(ChatSendMedia(media: event.chatmedia));
      },
    );
    on<ChatTextEvent>(
      (event, emit) {
        emit(ChatSendText());
      },
    );
  }
}

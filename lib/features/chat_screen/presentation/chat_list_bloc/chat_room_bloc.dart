import 'dart:io';

import 'package:beep/utils/helpers/base_url_helper.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:bloc/bloc.dart';
import 'package:beep/features/chat_screen/data/model/chat_data_response_model.dart';
import 'package:beep/features/chat_screen/domain/entity/chat_data_response_entity.dart';
import 'package:beep/features/chat_screen/domain/usecase/chat_data_usecase.dart';
import 'package:beep/utils/constants/url_constants.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:equatable/equatable.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatRoomDataUsecase chatRoomDataUsecase;

  ChatRoomBloc({required this.chatRoomDataUsecase}) : super(ChatRoomInitial()) {
    on<JoinChatRoom>((event, emit) async {
      ChatDataResponseEntity data =
          await chatRoomDataUsecase.call(params: event.roomid);
      SocketHelper.socket.emit("connect_room",
          {"userid": sharedPrefs.getid, "roomid": event.roomid});
      SocketHelper.socket.on(event.roomid, (socketData) {
        add(SocketGetMessageEvent(socketData: socketData));
      });
      emit(ChatRoomMessageState(messages: data.data ?? []));
    });
    on<SocketGetMessageEvent>(
      (event, emit) {
        var socketData = event.socketData;
        print("socket data $socketData");
        List<ChatRoomMessage> parseddata = [];
        for (int i = 0; i < socketData.length; i++) {
          parseddata.add(ChatRoomMessage(
              id: socketData[i]['_id'],
              message: socketData[i]['message'],
              senderId: socketData[i]['senderId'],
              senderName: socketData[i]['senderName'],
              senderNumber: socketData[i]['senderNumber'],
              image: "${AppUrl.baseUrl}${socketData[i]['image']}",
              messagetype: socketData[i]['messagetype'],
              timestamp: DateTime.parse(socketData[i]['timestamp'])));
        }
        emit(ChatRoomMessageState(messages: parseddata));
      },
    );
    on<ChatroomDisconnect>(
      (event, emit) {
        print("Chatroom Socket Disconnected");

        SocketHelper.socket.off(event.roomid);
        SocketHelper.socket
            .emit("disconnect_room", {"userid": sharedPrefs.getid});
        emit(ChatRoomInitial());
      },
    );
  }
}

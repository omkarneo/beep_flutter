import 'package:beep/features/chat_screen/data/model/chat_data_response_model.dart';

class ChatDataResponseEntity {
  String? status;
  List<ChatRoomMessage>? data;
  String? receiverStatus;

  ChatDataResponseEntity({this.status, this.data, this.receiverStatus});
}

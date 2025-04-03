import 'package:beep/features/chat_screen/domain/entity/chat_data_response_entity.dart';

abstract class ChatDataRepo {
  Future<ChatDataResponseEntity> getData(String roomid);
  Future<ChatDataResponseEntity> getUserStatus(String userid);
}

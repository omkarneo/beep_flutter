import 'package:chat_app/features/chat_screen/data/data_source/chat_data_response_ds.dart';
import 'package:chat_app/features/chat_screen/data/model/chat_data_response_model.dart';
import 'package:chat_app/features/chat_screen/domain/entity/chat_data_response_entity.dart';
import 'package:chat_app/features/chat_screen/domain/repo/chat_data_repo.dart';
import 'package:chat_app/features/dashboard/data/datasource/create_room_ds.dart';
import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';

class ChatDataRepoImpl extends ChatDataRepo {
  final ChatDataResponseDs chatDataResponseDs;
  ChatDataRepoImpl({required this.chatDataResponseDs});
  @override
  Future<ChatRoomResponseModel> getData(String roomid) async {
    return await chatDataResponseDs.roomApiCall(roomid);
  }

  @override
  Future<ChatDataResponseEntity> getUserStatus(String userid) async {
    return await chatDataResponseDs.getStatusApiCall(userid);
  }
}

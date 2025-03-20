import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';

abstract class CreateRoomRepo {
  Future<CreateRoomResponseEntity> createRoom(String receiverUserId);
}

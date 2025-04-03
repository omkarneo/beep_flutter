import 'package:beep/features/dashboard/domain/entity/room_entity.dart';

abstract class GetRoomRepo {
  Future<RoomResponseEntity> getRoomData();
}

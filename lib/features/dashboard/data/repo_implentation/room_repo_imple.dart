import 'package:chat_app/features/dashboard/data/datasource/getroom_ds.dart';
import 'package:chat_app/features/dashboard/domain/entity/room_entity.dart';
import 'package:chat_app/features/dashboard/domain/repo/room_repo.dart';

class RoomRepoImple extends GetRoomRepo {
  final RoomGetDataSource roomGetDataSource;
  RoomRepoImple({required this.roomGetDataSource});
  @override
  Future<RoomResponseEntity> getRoomData() async {
    return await roomGetDataSource.roomApiCall();
  }
}

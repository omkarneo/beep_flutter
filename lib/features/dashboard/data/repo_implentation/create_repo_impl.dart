import 'package:chat_app/features/dashboard/data/datasource/create_room_ds.dart';
import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:chat_app/features/dashboard/domain/repo/create_room_repo.dart';

class CreateRepoImpl extends CreateRoomRepo {
  final CreateRoomDataSource createRoomDataSource;
  CreateRepoImpl({required this.createRoomDataSource});
  @override
  Future<CreateRoomResponseEntity> createRoom(String receiverUserId) async {
    return await createRoomDataSource.roomApiCall(receiverUserId);
  }
}

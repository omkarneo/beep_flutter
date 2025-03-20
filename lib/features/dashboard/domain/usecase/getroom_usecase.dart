import 'package:chat_app/features/dashboard/domain/entity/room_entity.dart';
import 'package:chat_app/utils/base_usecase.dart';
import 'package:chat_app/features/dashboard/domain/repo/room_repo.dart';

class GetRoomDataUseCase extends UseCase {
  final GetRoomRepo getRoomRepo;
  GetRoomDataUseCase({required this.getRoomRepo});
  @override
  Future<RoomResponseEntity> call({required params}) async {
    return await getRoomRepo.getRoomData();
  }
}

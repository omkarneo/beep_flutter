import 'package:beep/features/dashboard/domain/entity/room_entity.dart';
import 'package:beep/utils/base_usecase.dart';
import 'package:beep/features/dashboard/domain/repo/room_repo.dart';

class GetRoomDataUseCase extends UseCase {
  final GetRoomRepo getRoomRepo;
  GetRoomDataUseCase({required this.getRoomRepo});
  @override
  Future<RoomResponseEntity> call({required params}) async {
    return await getRoomRepo.getRoomData();
  }
}

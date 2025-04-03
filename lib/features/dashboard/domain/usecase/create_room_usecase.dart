import 'package:beep/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:beep/features/dashboard/domain/repo/create_room_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class CreateRoomUsecase extends UseCase {
  final CreateRoomRepo createRoomRepo;
  CreateRoomUsecase({required this.createRoomRepo});
  @override
  Future<CreateRoomResponseEntity> call({required params}) async {
    return await createRoomRepo.createRoom(params);
  }
}

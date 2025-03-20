import 'package:chat_app/features/chat_screen/domain/entity/chat_data_response_entity.dart';
import 'package:chat_app/features/chat_screen/domain/repo/chat_data_repo.dart';
import 'package:chat_app/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:chat_app/features/dashboard/domain/repo/create_room_repo.dart';
import 'package:chat_app/utils/base_usecase.dart';

class ChatRoomDataUsecase extends UseCase {
  final ChatDataRepo chatDataRepo;
  ChatRoomDataUsecase({required this.chatDataRepo});
  @override
  Future<ChatDataResponseEntity> call({required params}) async {
    return await chatDataRepo.getData(params);
  }
}

class GetUserStatusUsecase extends UseCase {
  final ChatDataRepo chatDataRepo;
  GetUserStatusUsecase({required this.chatDataRepo});
  @override
  Future<ChatDataResponseEntity> call({required params}) async {
    return await chatDataRepo.getUserStatus(params);
  }
}

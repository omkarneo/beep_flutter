import 'package:beep/features/dashboard/domain/entity/status_response_entity.dart';
import 'package:beep/features/dashboard/domain/repo/status_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class StatusGetUsecase extends UseCase {
  final StatusRepo statusRepo;
  StatusGetUsecase({required this.statusRepo});
  @override
  Future<StatusChatResponeEntity> call({required params}) {
    return statusRepo.getUserData();
  }
}

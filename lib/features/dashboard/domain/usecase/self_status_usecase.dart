import 'package:beep/features/dashboard/domain/entity/get_self_status_response.dart';
import 'package:beep/features/dashboard/domain/repo/self_status_repo.dart';

import 'package:beep/utils/base_usecase.dart';

class SelfStatusUsecase extends UseCase {
  final SelfStatusRepo selfStatusRepo;
  SelfStatusUsecase({
    required this.selfStatusRepo,
  });
  @override
  Future<StatusSelfResponeEntity> call({required params}) async {
    return await selfStatusRepo.getselfStatusData();
  }
}

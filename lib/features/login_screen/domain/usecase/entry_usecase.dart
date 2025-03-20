import 'package:chat_app/features/login_screen/domain/entity/otp_response_entity.dart';
import 'package:chat_app/features/login_screen/domain/entity/response_entry_entity.dart';
import 'package:chat_app/features/login_screen/domain/repository/entry_repo.dart';
import 'package:chat_app/utils/base_usecase.dart';

class EntryUseCase extends UseCase {
  final EntryRepo entryRepo;
  EntryUseCase({required this.entryRepo});

  @override
  Future<EntryResponseEntity> call({required params}) async {
    return await entryRepo.authentication(params);
  }
}

class OtpVerifyUse extends UseCase {
  final EntryRepo entryRepo;
  OtpVerifyUse({required this.entryRepo});
  @override
  Future<OtpResponseEntity> call({required params}) async {
    return await entryRepo.verifyOtp(params);
  }
}

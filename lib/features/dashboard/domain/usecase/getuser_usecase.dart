import 'package:beep/features/dashboard/domain/entity/search_entity.dart';
import 'package:beep/features/dashboard/domain/repo/search_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class GetUserData extends UseCase {
  final SearchRepo searchRepo;
  GetUserData({required this.searchRepo});
  @override
  Future<SearchResponseEntity> call({required params}) async {
    return await searchRepo.getUserData();
  }
}

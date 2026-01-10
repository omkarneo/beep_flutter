import 'package:beep/features/dashboard/domain/entity/post_response_entity.dart';
import 'package:beep/features/dashboard/domain/repo/post_repo.dart';
import 'package:beep/utils/base_usecase.dart';

class GetPostUsecase extends UseCase {
  final PostRepo postRepo;
  GetPostUsecase({required this.postRepo});
  @override
  Future<PostResponseEntity> call({required params}) async {
    return await postRepo.getPost();
  }
}

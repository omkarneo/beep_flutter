import 'package:beep/features/dashboard/data/datasource/get_post_ds.dart';
import 'package:beep/features/dashboard/data/model/post_response_model.dart';
import 'package:beep/features/dashboard/domain/entity/create_room_response_entity.dart';
import 'package:beep/features/dashboard/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final GetPostDataSource getPostDataSource;
  PostRepoImpl({required this.getPostDataSource});
  @override
  Future<PostResponseModel> getPost() async {
    return await getPostDataSource.getApiCall();
  }
}

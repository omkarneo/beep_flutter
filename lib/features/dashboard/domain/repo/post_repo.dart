import 'package:beep/features/dashboard/domain/entity/post_response_entity.dart';

abstract class PostRepo {
  Future<PostResponseEntity> getPost();
}

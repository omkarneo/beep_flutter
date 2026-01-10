class PostResponseEntity {
  final String status;
  final List<PostEnity> data;

  PostResponseEntity({
    required this.status,
    required this.data,
  });

  PostResponseEntity copyWith({
    String? status,
    List<PostEnity>? data,
  }) =>
      PostResponseEntity(
        status: status ?? this.status,
        data: data ?? this.data,
      );
}

class PostEnity {
  final String id;
  final String userId;
  final String userName;
  final String userPhoto;
  final bool isActive;
  final List<PostPhotoEnity> postPhotos;
  final String postDescription;
  final List<PostLikeEnity> postLikes;
  final List<PostCommentEnity> postComments;
  final int v;

  PostEnity(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.isActive,
      required this.postPhotos,
      required this.postDescription,
      required this.postLikes,
      required this.postComments,
      required this.v,
      required this.userPhoto});
}

class PostCommentEnity {
  final String commentUserId;
  final String commentUserName;
  final String commentUserPhoto;
  final String comment;
  final String id;

  PostCommentEnity({
    required this.commentUserId,
    required this.commentUserName,
    required this.commentUserPhoto,
    required this.comment,
    required this.id,
  });
}

class PostLikeEnity {
  final String likedUserId;
  final String likedUserName;
  final String likedUserPhoto;
  final String id;

  PostLikeEnity({
    required this.likedUserId,
    required this.likedUserName,
    required this.likedUserPhoto,
    required this.id,
  });
}

class PostPhotoEnity {
  final String post;
  final String postUniqueId;
  final String id;

  PostPhotoEnity({
    required this.post,
    required this.postUniqueId,
    required this.id,
  });
}

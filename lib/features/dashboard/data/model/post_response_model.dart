import 'dart:convert';

import 'package:beep/features/dashboard/domain/entity/post_response_entity.dart';

PostResponseModel postResponseModelFromJson(String str) =>
    PostResponseModel.fromJson(json.decode(str));

String postResponseModelToJson(PostResponseModel data) =>
    json.encode(data.toJson());

class PostResponseModel extends PostResponseEntity {
  final String status;
  final List<Post> data;

  PostResponseModel({
    required this.status,
    required this.data,
  }) : super(status: status, data: data);

  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      PostResponseModel(
        status: json["status"],
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Post extends PostEnity {
  final String id;
  final String userId;
  final String userName;
  final String userPhoto;
  final bool isActive;
  final List<PostPhoto> postPhotos;
  final String postDescription;
  final List<PostLike> postLikes;
  final List<PostComment> postComments;
  final int v;

  Post(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.isActive,
      required this.postPhotos,
      required this.postDescription,
      required this.postLikes,
      required this.postComments,
      required this.v,
      required this.userPhoto})
      : super(
            id: id,
            userId: userId,
            userName: userName,
            isActive: isActive,
            postPhotos: postPhotos,
            postDescription: postDescription,
            postLikes: postLikes,
            postComments: postComments,
            userPhoto: userPhoto,
            v: 0);

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        userId: json["userId"],
        userName: json["userName"],
        userPhoto: json['userPhoto'],
        isActive: json["isActive"],
        postPhotos: List<PostPhoto>.from(
            json["postPhotos"].map((x) => PostPhoto.fromJson(x))),
        postDescription: json["postDescription"],
        postLikes: List<PostLike>.from(
            json["postLikes"].map((x) => PostLike.fromJson(x))),
        postComments: List<PostComment>.from(
            json["postComments"].map((x) => PostComment.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "userName": userName,
        "isActive": isActive,
        "postPhotos": List<dynamic>.from(postPhotos.map((x) => x.toJson())),
        "postDescription": postDescription,
        "postLikes": List<dynamic>.from(postLikes.map((x) => x.toJson())),
        "postComments": List<dynamic>.from(postComments.map((x) => x.toJson())),
        "__v": v,
      };
}

class PostComment extends PostCommentEnity {
  final String commentUserId;
  final String commentUserName;
  final String commentUserPhoto;
  final String comment;
  final String id;

  PostComment({
    required this.commentUserId,
    required this.commentUserName,
    required this.commentUserPhoto,
    required this.comment,
    required this.id,
  }) : super(
            commentUserId: commentUserId,
            commentUserName: commentUserName,
            commentUserPhoto: commentUserPhoto,
            comment: comment,
            id: id);

  PostComment copyWith({
    String? commentUserId,
    String? commentUserName,
    String? commentUserPhoto,
    String? comment,
    String? id,
  }) =>
      PostComment(
        commentUserId: commentUserId ?? this.commentUserId,
        commentUserName: commentUserName ?? this.commentUserName,
        commentUserPhoto: commentUserPhoto ?? this.commentUserPhoto,
        comment: comment ?? this.comment,
        id: id ?? this.id,
      );

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        commentUserId: json["commentUserId"],
        commentUserName: json["commentUserName"],
        commentUserPhoto: json["commentUserPhoto"],
        comment: json["comment"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "commentUserId": commentUserId,
        "commentUserName": commentUserName,
        "commentUserPhoto": commentUserPhoto,
        "comment": comment,
        "_id": id,
      };
}

class PostLike extends PostLikeEnity {
  final String likedUserId;
  final String likedUserName;
  final String likedUserPhoto;
  final String id;

  PostLike({
    required this.likedUserId,
    required this.likedUserName,
    required this.likedUserPhoto,
    required this.id,
  }) : super(
            likedUserId: likedUserId,
            likedUserName: likedUserName,
            likedUserPhoto: likedUserPhoto,
            id: id);

  factory PostLike.fromJson(Map<String, dynamic> json) => PostLike(
        likedUserId: json["likedUserId"],
        likedUserName: json["likedUserName"],
        likedUserPhoto: json["likedUserPhoto"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "likedUserId": likedUserId,
        "likedUserName": likedUserName,
        "likedUserPhoto": likedUserPhoto,
        "_id": id,
      };
}

class PostPhoto extends PostPhotoEnity {
  final String post;
  final String postUniqueId;
  final String id;

  PostPhoto({
    required this.post,
    required this.postUniqueId,
    required this.id,
  }) : super(post: post, postUniqueId: postUniqueId, id: id);

  factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
        post: json["post"],
        postUniqueId: json["postUniqueId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "post": post,
        "postUniqueId": postUniqueId,
        "_id": id,
      };
}

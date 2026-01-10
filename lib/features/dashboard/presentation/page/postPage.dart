import 'package:beep/features/dashboard/domain/entity/post_response_entity.dart';
import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/features/dashboard/presentation/page/profilepage.dart';
import 'package:beep/features/dashboard/presentation/widget/testexpanded.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/helpers/base_url_helper.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(DashboardPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 200,
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardPostState) {
            return ListView.separated(
              itemCount: state.postData!.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (context, index) {
                return PostWidgetTile(
                  data: state.postData![index],
                  //             data: PostEnity(
                  //                 id: "694e56010489072a94cc99bd",
                  //                 userId: "694bb513163290a6fb3a0f4e",
                  //                 userName: "Omkar Parekh",
                  //                 userPhoto: "/uploads/profile/file-1744967808593.jpg",
                  //                 isActive: true,
                  //                 postPhotos: [
                  //                   PostPhotoEnity(
                  //                       id: "694e56010489072a94cc99be",
                  //                       post:
                  //                           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/500px-Image_created_with_a_mobile_phone.png",
                  //                       postUniqueId: "2"),
                  //                   PostPhotoEnity(
                  //                       id: "694e56010489072a94cc99be",
                  //                       post:
                  //                           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/500px-Image_created_with_a_mobile_phone.png",
                  //                       postUniqueId: "3"),
                  //                   PostPhotoEnity(
                  //                       id: "694e56010489072a94cc99be",
                  //                       post:
                  //                           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/500px-Image_created_with_a_mobile_phone.png",
                  //                       postUniqueId: "4"),
                  //                 ],
                  //                 postDescription:
                  //                     """Sometimes life doesn’t change all at once — it changes quietly, in small moments we don’t notice at first. A decision made late at night, a habit broken, a new one formed, or simply choosing yourself when it’s easier not to.

                  // Growth is not loud. It’s patient. It’s the effort you put in when no one is watching, the consistency you maintain even when motivation fades. Today, remind yourself how far you’ve come — not just how far you still have to go.

                  // Keep going. Your future self is already thankful. 🌱✨""",
                  //                 postLikes: [
                  //                   PostLikeEnity(
                  //                       id: "694e58e4a3deaec5b1c0f821",
                  //                       likedUserId: "694bb513163290a6fb3a0f4e",
                  //                       likedUserName: "Omkar Parekh",
                  //                       likedUserPhoto:
                  //                           "/uploads/profile/file-1744967808593.jpg"),
                  //                   PostLikeEnity(
                  //                       id: "694e58e4a3deaec5b1c0f821",
                  //                       likedUserId: "694bb513163290a6fb3a0f4e",
                  //                       likedUserName: "Akash Kharmale",
                  //                       likedUserPhoto:
                  //                           "/uploads/profile/file-1744967808593.jpg"),
                  //                   PostLikeEnity(
                  //                       id: "694e58e4a3deaec5b1c0f821",
                  //                       likedUserId: "694bb513163290a6fb3a0f4e",
                  //                       likedUserName: "Jabbar Shaikh",
                  //                       likedUserPhoto:
                  //                           "/uploads/profile/file-1744967808593.jpg"),
                  //                   PostLikeEnity(
                  //                       id: "694e58e4a3deaec5b1c0f821",
                  //                       likedUserId: "694bb513163290a6fb3a0f4e",
                  //                       likedUserName: "Abhay Kapades",
                  //                       likedUserPhoto:
                  //                           "/uploads/profile/file-1744967808593.jpg"),
                  //                 ],
                  //                 postComments: [
                  //                   PostCommentEnity(
                  //                       comment: "Test 2",
                  //                       commentUserId: "694bb513163290a6fb3a0f4e",
                  //                       commentUserName: "Omkar Parekh",
                  //                       commentUserPhoto:
                  //                           "/uploads/profile/file-1744967808593.jpg",
                  //                       id: "69609b8b450fed482fb97b24")
                  //                 ],
                  //                 v: 0),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PostWidgetTile extends StatefulWidget {
  const PostWidgetTile({super.key, required this.data});
  final PostEnity data;

  @override
  State<PostWidgetTile> createState() => _PostWidgetTileState();
}

class _PostWidgetTileState extends State<PostWidgetTile> {
  @override
  Widget build(BuildContext context) {
    String LikedPersons = widget.data.postLikes
        .take(2)
        .map((e) => e.likedUserName.split(' ').first)
        .join(', ');
    ;
    return Container(
      // color: secondaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: yellowprimary, width: 2),
                      image: DecorationImage(
                          image: NetworkImage(
                            "${AppUrl.baseUrl}${widget.data.userPhoto}",
                          ),
                          fit: BoxFit.fitWidth)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.data.userName,
                  style: TextStyleHelper.mediumStyle(color: primaryTextColor),
                ),
                Spacer(),
                SvgPicture.asset(
                  "assets/images/menu.svg",
                  height: 30,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CarouselSlider.builder(
            itemCount: widget.data.postPhotos.length,
            itemBuilder: (context, index, realIndex) {
              final photoUrl = widget.data.postPhotos[index].post;

              return Image.network(
                photoUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
            options: CarouselOptions(
              // height: 350,
              viewportFraction: 1,
              enableInfiniteScroll: false,

              onPageChanged: (index, _) {
                // setState(() {
                //   _currentIndex = index;
                // });
              },
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.sizeOf(context).width,
          //   child: Image.network("${AppUrl.baseUrl}${widget.data.userPhoto}"),
          //   // height: MediaQuery.sizeOf(context).height * 0.5,
          // ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                (widget.data.userId != sharedPrefs.getid)
                    ? SvgPicture.asset(
                        "assets/images/unlike.svg",
                        height: 30,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      )
                    : SvgPicture.asset(
                        "assets/images/like.svg",
                        height: 30,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                SizedBox(
                  // height: 10,
                  width: 10,
                ),
                SvgPicture.asset(
                  "assets/images/comment.svg",
                  height: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  // height: 10,
                  width: 10,
                ),
                SvgPicture.asset(
                  "assets/images/send_message.svg",
                  height: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    for (int i = 0;
                        i <
                            (widget.data.postLikes.length > 2
                                ? 3
                                : widget.data.postLikes.length);
                        i++)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: yellowprimary, width: 1),
                            image: DecorationImage(
                                image: NetworkImage(
                                  "${AppUrl.baseUrl}${widget.data.postLikes[i].likedUserPhoto}",
                                ),
                                fit: BoxFit.fitWidth)),
                      ),
                  ],
                ),
                SizedBox(
                  width: widget.data.postLikes.length != 0 ? 10 : 0,
                ),
                widget.data.postLikes.length != 0
                    ? Text(
                        "Liked By $LikedPersons ${widget.data.postLikes.length > 2 ? "and others" : ""}",
                        style: TextStyleHelper.mediumStyle(
                            color: primaryTextColor, fontSize: 15),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ExpandableText(
                text: widget.data.postDescription,
              ))
        ],
      ),
    );
  }
}

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Text(
            "Welcome ",
            style: TextStyleHelper.lightStyle(
                    color: primaryTextColor, fontSize: 20)
                .copyWith(letterSpacing: -1),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            "Back,",
            style: TextStyleHelper.lightStyle(
                    color: primaryTextColor, fontSize: 20)
                .copyWith(letterSpacing: -2),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "${sharedPrefs.getname}",
            style:
                TextStyleHelper.boldStyle(fontSize: 20, color: primaryTextColor)
                    .copyWith(letterSpacing: -2),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            "",
            style:
                TextStyleHelper.boldStyle(fontSize: 20, color: primaryTextColor)
                    .copyWith(letterSpacing: -2),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    )).then(
                  (value) {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(DashboardPostEvent());
                  },
                );
              },
              child: Hero(
                tag: "userphoto",
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: yellowprimary, width: 2),
                      image: DecorationImage(
                          image: NetworkImage(
                            sharedPrefs.getuserPhoto,
                          ),
                          fit: BoxFit.fitWidth)),
                ),
              ),
            ),
          ),
          // Image.network();
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:beep/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/features/dashboard/data/model/room_model.dart';
import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/router/arguments/chatscreen_argymenjt.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatListPage extends StatefulWidget {
  ChatListPage({super.key, required this.profile});
  final List profile;

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(DashboardChatEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            width: 150,
            height: 5,
            decoration: BoxDecoration(
                color: chatlistdashcolor,
                borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(
            height: 15,
          ),
          ChatWidget(
            profile: widget.profile,
          ),
        ],
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.profile});

  final List profile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          print(state);
          if (state is DashboardChatState) {
            if (state.roomData!.isEmpty) {
              return Center(
                child: Text("No conversations found."),
              );
            } else {
              return ListView.separated(
                itemCount: state.roomData!.length,
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 20, right: 20),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                itemBuilder: (context, index) {
                  if (index == (state.roomData!.length - 1)) {
                    return Column(
                      children: [
                        ChatTile(
                          chatTileData: state.roomData![index],
                          index: index,
                        ),
                        Container(
                          height: 100,
                        )
                      ],
                    );
                  }
                  return ChatTile(
                    chatTileData: state.roomData![index],
                    index: index,
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: yellowprimary,
              ),
            );
          }
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chatTileData,
    required this.index,
  });

  final RoomData chatTileData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Status Socket ${chatTileData.receviernumber}");
        print("search page ${chatTileData.roomId}");
        Navigator.pushNamed(context, AppRoutes.chatScreen,
                arguments: ChatscreenArgument(
                    roomid: chatTileData.roomId!,
                    phonenumber: chatTileData.receviernumber ?? "",
                    name: chatTileData.recevierName ?? "",
                    photo: chatTileData.recevierphoto,
                    receiverId: chatTileData.recevierid!))
            .then((data) {
          BlocProvider.of<StatusBloc>(context).add(StatusDisconnect());
          BlocProvider.of<ChatRoomBloc>(context)
              .add(ChatroomDisconnect(roomid: chatTileData.roomId!));
          BlocProvider.of<DashboardBloc>(context).add(DashboardChatEvent());
        });
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(
                        chatTileData.recevierphoto!,
                      ),
                      fit: BoxFit.fitWidth)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chatTileData.recevierName ?? "",
                    style: TextStyleHelper.boldStyle(fontSize: 15)
                        .copyWith(letterSpacing: -1),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(chatTileData.lastchat ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyleHelper.mediumStyle(
                          fontSize: 14, color: subtextColors)),
                ],
              ),
            ),
            // Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                // DateFormat('dd MMM, hh:mm a')
                //     .format(DateTime.parse(chatTileData.lastchatTime ?? "")),
                //   style: TextStyleHelper.mediumStyle(
                //       fontSize: 12, color: subtextColors),
                // ),
                SizedBox(
                  height: 6,
                ),
                (chatTileData.hasBeenRead == false)
                    ? Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: primaryBackground,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            chatTileData.unReadCount.toString(),
                            style: TextStyleHelper.boldStyle(
                                color: primaryTextColor),
                          ),
                        ),
                      )
                    : SizedBox.shrink()
                // Icon(
                //   Icons.check_rounded,
                //   size: 17,
                // )
              ],
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
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
        ],
      ),
    );
  }
}

class StatusGridWidget extends StatelessWidget {
  const StatusGridWidget({
    super.key,
    required this.profile,
  });

  final List profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 34),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 130,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardChatState) {
              if (state.statusData!.length == 0) {
                return Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    AddStoryWidget(),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  width: 14,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: state.statusData?.length ?? 0,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        AddStoryWidget(),
                        SizedBox(
                          width: 14,
                        ),
                        StoryWidget(
                            image: state.statusData?[index].userPhotos ?? "",
                            name: state.statusData?[index].username ?? "")
                      ],
                    );
                  } else {
                    return StoryWidget(
                        image: state.statusData?[index].userPhotos ?? "",
                        name: state.statusData?[index].username ?? "");
                  }
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: yellowprimary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddStoryWidget extends StatelessWidget {
  const AddStoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: yellowprimary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              // width: 69,
              // height: 69,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryBackground,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 2),
                  color: yellowprimary,
                  borderRadius: BorderRadius.circular(40)),
              child: Icon(
                Icons.add_circle,
                color: secondaryTextColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Add Story",
          style: TextStyleHelper.mediumStyle(
              fontSize: 13, color: primaryTextColor),
        )
      ],
    );
  }
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: yellowprimary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              // width: 69,
              // height: 69,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: primaryBackground,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 5),
                  // color: yellowprimary,
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(image),
                  )),
              // child: Image.network(image),
            ),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Text(
          name.split(" ")[0],
          style: TextStyleHelper.mediumStyle(
              fontSize: 13, color: primaryTextColor),
        )
      ],
    );
  }
}

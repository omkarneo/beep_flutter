import 'dart:io';

import 'package:beep/features/chat_screen/data/model/chat_data_response_model.dart';
import 'package:beep/features/chat_screen/presentation/bloc/chat_send_bloc.dart';
import 'package:beep/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/constants/text_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:beep/utils/router/arguments/camera_page_argument.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String? photos;
  final String phonenumber;
  final String roomid;
  final String receiverId;
  const ChatScreen(
      {super.key,
      required this.name,
      required this.phonenumber,
      this.photos,
      required this.roomid,
      required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    BlocProvider.of<StatusBloc>(context)
        .add(GetUserStatusEvent(receiverId: widget.receiverId));
    BlocProvider.of<StatusBloc>(context)
        .add(StartStatusSocketEvent(phoneNumber: widget.phonenumber));

    BlocProvider.of<ChatRoomBloc>(context)
        .add(JoinChatRoom(roomid: widget.roomid));

    super.initState();
    // SocketHelper.joinRoom();
  }

  @override
  void dispose() {
    print("Socket dispose");
    BlocProvider.of<ChatRoomBloc>(context)
        .add(ChatroomDisconnect(roomid: widget.roomid));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            ProfileTile(
              name: widget.name,
              photos: widget.photos,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: secondaryBackground),
                child: Column(
                  children: [
                    SizedBox(height: 15),
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
                    ChatList(),
                    ChatTextFormWidget(
                      receiverId: widget.receiverId,
                      roomid: widget.roomid,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatTextFormWidget extends StatelessWidget {
  final String roomid;
  final String receiverId;

  ChatTextFormWidget({
    required this.roomid,
    required this.receiverId,
    super.key,
  });

  final TextEditingController chatbox = TextEditingController();
  ValueNotifier<bool> isEmpty = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSendBloc, ChatSendState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: MediaQuery.sizeOf(context).width,
            height: (state is ChatSendMedia) ? 160 : 64,
            decoration: BoxDecoration(
                border:
                    Border.all(color: bordercolor.withOpacity(0.25), width: 2),
                borderRadius:
                    BorderRadius.circular((state is ChatSendMedia) ? 50 : 167)),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.sp),
                          topRight: Radius.circular(10.sp),
                        ),
                      ),
                      isScrollControlled: true,
                      // barrierColor: transparent,

                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(16),

                          width: double.infinity,
                          // height: MediaQuery.sizeOf(context).height < 650
                          //     ? MediaQuery.sizeOf(context).height * 0.45
                          //     : MediaQuery.sizeOf(context).height * 0.365,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: secondaryBackground,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                  onTap: () async {
                                    var cameras = await availableCameras();
                                    print(cameras);
                                    var picture = await Navigator.pushNamed(
                                        context, AppRoutes.cameraScreen,
                                        arguments: CameraPageArgument(
                                            cameras: cameras,
                                            fromchatScreen: false));
                                    if (picture != null) {
                                      final imageTemp =
                                          File((picture as XFile).path);
                                      BlocProvider.of<ChatSendBloc>(context)
                                          .add(ChatMediaEvent(
                                              chatmedia: imageTemp));
                                      Navigator.pop(context);
                                    }
                                  },
                                  leading: Icon(Icons.camera_alt),
                                  title: Text("Camera")),
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text("Gallery"),
                                onTap: () async {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);

                                  if (image != null) {
                                    final imageTemp = File(image.path);
                                    BlocProvider.of<ChatSendBloc>(context).add(
                                        ChatMediaEvent(chatmedia: imageTemp));
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                    // final image = await ImagePicker()
                    //     .pickImage(source: ImageSource.gallery);

                    // if (image != null) {
                    //   final imageTemp = File(image.path);
                    //   BlocProvider.of<ChatSendBloc>(context)
                    //       .add(ChatMediaEvent(chatmedia: imageTemp));
                    // }
                    //   // photoUpdated.value = imageTemp;
                    //   SocketHelper.socket.emit("sendMessage", {
                    //     "senderId": sharedPrefs.getid,
                    //     "roomId": roomid,
                    //     "message": chatbox.text == "" ? "Hello" : chatbox.text,
                    //     "messagetype": "image"
                    //   });
                    // }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                          color: yellowprimary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.add,
                        weight: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (state is ChatSendMedia)
                            ? Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    // height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2, color: yellowprimary),
                                        image: DecorationImage(
                                          image: FileImage(state.media),
                                        )),
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<ChatSendBloc>(context)
                                            .add(ChatTextEvent());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        TextFormField(
                            controller: chatbox,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isEmpty.value = true;
                              } else {
                                isEmpty.value = false;
                              }
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: "Type Message",
                                hintStyle: TextStyleHelper.regularStyle(
                                    fontSize: 14))),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 33,
                  width: 2,
                  color: bordercolor.withOpacity(0.25),
                ),
                SizedBox(
                  width: 10,
                ),
                ValueListenableBuilder(
                    valueListenable: isEmpty,
                    builder: (context, value, _) {
                      return InkWell(
                        onTap: (state is ChatSendMedia)
                            ? () {
                                BlocProvider.of<ChatSendBloc>(context).add(
                                    SendMessageEvent(
                                        message: chatbox.text == ""
                                            ? ""
                                            : chatbox.text,
                                        receiverId: receiverId,
                                        roomid: roomid,
                                        chatmedia: state.media,
                                        senderid: sharedPrefs.getid));
                                chatbox.text = "";
                              }
                            : value
                                ? () {
                                    BlocProvider.of<ChatSendBloc>(context).add(
                                        SendMessageEvent(
                                            message: chatbox.text == ""
                                                ? ""
                                                : chatbox.text,
                                            receiverId: receiverId,
                                            roomid: roomid,
                                            senderid: sharedPrefs.getid));

                                    chatbox.text = "";
                                  }
                                : null,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 39,
                            height: 39,
                            decoration: BoxDecoration(
                                color: yellowprimary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Icon(
                              (state is ChatSendMedia)
                                  ? Icons.send_rounded
                                  : (!value)
                                      ? Icons.mic
                                      : Icons.send_rounded,
                              weight: 50,
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ChatList extends StatelessWidget {
  ChatList({
    super.key,
  });

  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      builder: (context, state) {
        if (state is ChatRoomMessageState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            //  if (!mounted) return;
            listScrollController.animateTo(
              listScrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          });

          List<ChatRoomMessage> chatData = state.messages;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20),
              child: (chatData.length == 0)
                  ? Center(child: Text("No Communication Begun."))
                  : ListView.builder(
                      controller: listScrollController,
                      reverse: true,
                      itemCount: chatData.length,
                      itemBuilder: (context, index) {
                        final reversedIndex = chatData.length - 1 - index;
                        return Chattile(
                          chatData: chatData,
                          index: reversedIndex,
                        );
                      },
                    ),
            ),
          );
        } else {
          return Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}

class Chattile extends StatelessWidget {
  const Chattile({super.key, required this.chatData, required this.index});

  final List<ChatRoomMessage> chatData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      crossAxisAlignment: chatData[index].senderId != sharedPrefs.getid
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          // height: 38.h,
          // width: 10,
          decoration: BoxDecoration(
              // color: otherChatTileColor.withOpacity(0.25),
              color: chatData[index].senderId != sharedPrefs.getid
                  ? otherChatTileColor.withOpacity(0.25)
                  : myChatTileColor.withOpacity(0.25),
              borderRadius: BorderRadius.only(
                  topRight: chatData[index].messagetype == "image"
                      ? Radius.circular(10)
                      : Radius.circular(50),
                  bottomRight: chatData[index].senderId != sharedPrefs.getid
                      ? chatData[index].messagetype == "image"
                          ? Radius.circular(10)
                          : Radius.circular(50)
                      : Radius.circular(0),
                  bottomLeft: chatData[index].senderId != sharedPrefs.getid
                      ? Radius.circular(0)
                      : chatData[index].messagetype == "image"
                          ? Radius.circular(10)
                          : Radius.circular(50),
                  topLeft: chatData[index].messagetype == "image"
                      ? Radius.circular(10)
                      : Radius.circular(50))),
          child: Padding(
            padding: chatData[index].messagetype == "image"
                ? EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10)
                : EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                chatData[index].messagetype == "image"
                    ? Column(
                        crossAxisAlignment:
                            chatData[index].senderId != sharedPrefs.getid
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(chatData[index].image!))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            chatData[index].message ?? "",
                            style: TextStyleHelper.mediumStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )
                    : Text(
                        chatData[index].message ?? "",
                        style: TextStyleHelper.mediumStyle(
                          fontSize: 15,
                        ),
                      ),
              ],
            ),
          ),
        ),
        Text(
          DateFormat('dd MMM, hh:mm a').format(chatData[index].timestamp!) ??
              "",
          style: TextStyleHelper.mediumStyle(fontSize: 10),
        )
      ],
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.name, this.photos});
  final String name;
  final String? photos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),

          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: primaryTextColor,
              )),
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: NetworkImage(
                      photos ?? emptyImage,
                    ),
                    fit: BoxFit.fitHeight)),
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
                  name,
                  style: TextStyleHelper.boldStyle(
                          fontSize: 15, color: primaryTextColor)
                      .copyWith(letterSpacing: -1),
                ),
                SizedBox(
                  height: 6,
                ),
                BlocBuilder<StatusBloc, StatusState>(
                  builder: (context, state) {
                    print("Status Socket $state");
                    return Text(
                        (state is StatusPageState)
                            ? state.statusMessage
                            : "Offline",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyleHelper.mediumStyle(
                            fontSize: 14,
                            color: (state is StatusPageState)
                                ? state.statusMessage == "Online"
                                    ? Colors.green
                                    : subtextColors
                                : subtextColors));
                  },
                ),
              ],
            ),
          ),
          // Spacer(),
          Icon(
            Icons.more_vert,
            size: 24,
            color: primaryTextColor,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

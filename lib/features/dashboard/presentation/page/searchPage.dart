import 'package:beep/features/chat_screen/presentation/chat_list_bloc/chat_room_bloc.dart';
import 'package:beep/features/chat_screen/presentation/status_bloc/status_bloc.dart';
import 'package:beep/features/dashboard/data/model/search_model.dart';
import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:beep/utils/router/arguments/chatscreen_argymenjt.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchTitleWidget extends StatefulWidget {
  const SearchTitleWidget({super.key});

  @override
  State<SearchTitleWidget> createState() => _CallTitleWidgetState();
}

class _CallTitleWidgetState extends State<SearchTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyleHelper.boldStyle(
                          color: primaryTextColor, fontSize: 30)
                      .copyWith(letterSpacing: -1),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.sort,
                      color: primaryTextColor,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  SearchWidget({
    super.key,
  });

  final TextEditingController chatbox = TextEditingController();
  ValueNotifier<bool> isEmpty = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 64,
      decoration: BoxDecoration(
          color: secondaryBackground,
          border: Border.all(color: bordercolor.withOpacity(0.25), width: 2),
          borderRadius: BorderRadius.circular(167)),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
                color: yellowprimary, borderRadius: BorderRadius.circular(30)),
            child: Icon(
              Icons.search,
              weight: 50,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextFormField(
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
                      hintText: "Search here",
                      hintStyle: TextStyleHelper.regularStyle(fontSize: 14)))),
        ],
      ),
    );
  }
}

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({
    super.key,
    required this.profile,
  });

  final List profile;

  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  @override
  void initState() {
    BlocProvider.of<DashboardBloc>(context).add(DashboardSearchEvent());
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
          BlocConsumer<DashboardBloc, DashboardState>(
            listener: (context, state) {
              if (state is DashboardSearchState) {
                print("search page111 ${state.roomid} ${state.roomid != null}");
                if (state.roomid != null) {
                  // print("search page ${state.data?[0].}");
                  // SocketHelper.init();
                  print("search page111 $state");
                  Navigator.pushNamed(context, AppRoutes.chatScreen,
                          arguments: ChatscreenArgument(
                              roomid: state.roomid!,
                              phonenumber: state.phonenumber ?? "",
                              name: state.name ?? "",
                              photo: state.photos,
                              receiverId: state.receiverId!))
                      .then((data) {
                    BlocProvider.of<StatusBloc>(context)
                        .add(StatusDisconnect());
                    BlocProvider.of<ChatRoomBloc>(context)
                        .add(ChatroomDisconnect(roomid: state.roomid!));
                  });
                }
              }
            },
            builder: (context, state) {
              // print(state);
              if (state is DashboardSearchState) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.data!.length,
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
                      if (index == (state.data!.length - 1)) {
                        return Column(
                          children: [
                            SearchTile(
                              userdata: state.data![index],
                              index: index,
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        );
                      }
                      return SearchTile(
                        userdata: state.data![index],
                        index: index,
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({super.key, required this.userdata, required this.index});

  final UserData userdata;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (userdata.firstName != null)
          ? () {
              BlocProvider.of<DashboardBloc>(context).add(
                  DashboardCreateRoomEvent(
                      receiverid: userdata.id!, index: index));
              // Navigator.pushNamed(context, AppRoutes.chatScreen);
            }
          : null,
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
                        userdata.photos ??
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
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
                    (userdata.firstName != null)
                        ? "${userdata.firstName} ${userdata.lastName}"
                        : "New User",
                    style: TextStyleHelper.boldStyle(fontSize: 15)
                        .copyWith(letterSpacing: -1),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(userdata.phonenumber ?? "",
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
                (userdata.firstName != null)
                    ? SvgPicture.asset(
                        "assets/images/message.svg",
                        color: primaryBackground,
                        width: 24,
                        height: 24,
                      )
                    : SizedBox(),
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

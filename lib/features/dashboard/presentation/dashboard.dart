import 'package:chat_app/features/dashboard/presentation/data.dart';
import 'package:chat_app/features/dashboard/presentation/page/callpage.dart';
import 'package:chat_app/features/dashboard/presentation/page/chatListPage.dart';
import 'package:chat_app/features/dashboard/presentation/page/profilepage.dart';
import 'package:chat_app/features/dashboard/presentation/page/searchPage.dart';
import 'package:chat_app/utils/constants/color_constants.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _ChatListScreenStateState();
}

class _ChatListScreenStateState extends State<DashboardScreen> {
  ValueNotifier<int> tab = ValueNotifier(0);
  int previousHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: tab,
        builder: (context, value, _) {
          return Scaffold(
            backgroundColor: primaryBackground,
            body: SafeArea(
              child: SizedBox(
                // height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: value == 3
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            (value == 0)
                                ? Column(
                                    children: [
                                      WelcomeBackWidget(),
                                    ],
                                  )
                                : (value == 1)
                                    ? SearchTitleWidget()
                                    : (value == 2)
                                        ? CallTitleWidget()
                                        : (value == 3)
                                            ? ProfileTitleWidget()
                                            : SizedBox.shrink(),
                            IgnorePointer(
                              ignoring: value == 0 || value == 1 || value == 3
                                  ? false
                                  : true,
                              child: (value == 0)
                                  ? StatusGridWidget(profile: profile)
                                  : (value == 1)
                                      ? Column(
                                          children: [
                                            SearchWidget(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : (value == 3)
                                          ? ProfilePhotoPage()
                                          : SizedBox.shrink(),
                            ),
                            Visibility(
                              visible: value == 3 ? false : true,
                              child: Container(
                                height: MediaQuery.sizeOf(context).height -
                                    ((value == 0)
                                        ? (242)
                                        : (value == 1)
                                            ? (137 + 74)
                                            : (value == 2)
                                                ? (137)
                                                : 147),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50)),
                                  color: secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (value == 0)
                                        ? ChatListPage(
                                            profile: profile,
                                          )
                                        : (value == 1)
                                            ? SearchListWidget(
                                                profile: profile,
                                              )
                                            : (value == 2)
                                                ? CallsPage()
                                                : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            bottomSheet: BottomMenu(
              index: value,
              tabcontroller: tab,
            ),
          );
        });
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu(
      {super.key, required this.index, required this.tabcontroller});

  final int index;
  final ValueNotifier tabcontroller;

  @override
  Widget build(BuildContext context) {
    // print($})
    return Container(
      color: secondaryBackground,
      height: 90,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                TabCalculator.previoustab = tabcontroller.value;
                tabcontroller.value = 0;
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/message.svg",
                    color: index == 0 ? primaryBackground : Colors.grey,
                    width: 24,
                    height: 24,
                  ),
                  Text(
                    "Message",
                    style: index == 0
                        ? TextStyleHelper.semiBoldStyle(fontSize: 12)
                        : TextStyleHelper.semiBoldStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                TabCalculator.previoustab = tabcontroller.value;
                tabcontroller.value = 1;
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/search.svg",
                    color: index == 1 ? primaryBackground : Colors.grey,
                    // color: primaryBackground,
                    width: 24,
                    height: 24,
                  ),
                  Text(
                    "Search",
                    style: index == 1
                        ? TextStyleHelper.semiBoldStyle(fontSize: 12)
                        : TextStyleHelper.semiBoldStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                    color: yellowprimary,
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.add,
                  weight: 9,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                TabCalculator.previoustab = tabcontroller.value;
                tabcontroller.value = 2;
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/phone.svg",
                    color: index == 2 ? primaryBackground : Colors.grey,
                    // color: primaryBackground,
                    width: 24,
                    height: 24,
                  ),
                  Text(
                    "Calls",
                    style: index == 2
                        ? TextStyleHelper.semiBoldStyle(fontSize: 12)
                        : TextStyleHelper.semiBoldStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                TabCalculator.previoustab = tabcontroller.value;
                tabcontroller.value = 3;
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/profile.svg",
                    color: index == 3 ? primaryBackground : Colors.grey,
                    // color: primaryBackground,
                    width: 24,
                    height: 24,
                  ),
                  Text(
                    "Profile",
                    style: index == 3
                        ? TextStyleHelper.semiBoldStyle(fontSize: 12)
                        : TextStyleHelper.semiBoldStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabCalculator {
  static int previoustab = 0;

  static heightchange(currenttab) {
    if (previoustab > currenttab) {
      return Duration.zero;
    } else {
      return Duration(milliseconds: 1000);
    }
  }
}

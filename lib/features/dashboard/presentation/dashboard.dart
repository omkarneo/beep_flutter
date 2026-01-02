import 'package:camera/camera.dart';
import 'package:beep/features/dashboard/presentation/data.dart';
import 'package:beep/features/dashboard/presentation/page/statuspage.dart';
import 'package:beep/features/dashboard/presentation/page/chatListPage.dart';
import 'package:beep/features/dashboard/presentation/page/profilepage.dart';
import 'package:beep/features/dashboard/presentation/page/searchPage.dart';
import 'package:beep/features/status_upload/presentation/status_upload.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/router/arguments/camera_page_argument.dart';
import 'package:beep/utils/router/arguments/status_upload_page_arg.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key, required this.lastindex});
//   final int lastindex;

//   @override
//   State<DashboardScreen> createState() => _ChatListScreenStateState();
// }

// class _ChatListScreenStateState extends State<DashboardScreen> {
//   ValueNotifier<int> tab = ValueNotifier(0);
//   int previousHeight = 0;

//   @override
//   void initState() {
//     tab.value = widget.lastindex;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: tab,
//         builder: (context, value, _) {
//           return Scaffold(
//             backgroundColor: primaryBackground,
//             body: SafeArea(
//               bottom: false,
//               top: true,
//               child: SizedBox(
//                 // height: MediaQuery.sizeOf(context).height,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: SingleChildScrollView(
//                     physics: NeverScrollableScrollPhysics(),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Column(
//                           mainAxisAlignment: value == 3
//                               ? MainAxisAlignment.start
//                               : MainAxisAlignment.end,
//                           children: [
//                             (value == 0)
//                                 ? Column(
//                                     children: [
//                                       WelcomeBackWidget(),
//                                     ],
//                                   )
//                                 : (value == 1)
//                                     ? SearchTitleWidget()
//                                     : (value == 2)
//                                         ? CallTitleWidget()
//                                         : (value == 3)
//                                             ? ProfileTitleWidget()
//                                             : SizedBox.shrink(),
//                             IgnorePointer(
//                               ignoring: value == 0 || value == 1 || value == 3
//                                   ? false
//                                   : true,
//                               child: (value == 0)
//                                   ? StatusGridWidget(profile: profile)
//                                   : (value == 1)
//                                       ? Column(
//                                           children: [
//                                             SearchWidget(),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                           ],
//                                         )
//                                       : (value == 3)
//                                           ? ProfilePhotoPage()
//                                           : SizedBox.shrink(),
//                             ),
//                             Visibility(
//                               visible: value == 3 ? false : true,
//                               child: Container(
//                                 height: MediaQuery.sizeOf(context).height -
//                                     ((value == 0)
//                                         ? (242)
//                                         : (value == 1)
//                                             ? (137 + 74)
//                                             : (value == 2)
//                                                 ? (137)
//                                                 : 147),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(50),
//                                       topRight: Radius.circular(50)),
//                                   color: secondaryBackground,
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     (value == 0)
//                                         ? ChatListPage(
//                                             profile: profile,
//                                           )
//                                         : (value == 1)
//                                             ? SearchListWidget(
//                                                 profile: profile,
//                                               )
//                                             : (value == 2)
//                                                 ? StatusPage()
//                                                 : SizedBox.shrink(),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//             ),
//             bottomSheet: BottomMenu(
//               index: value,
//               tabcontroller: tab,
//             ),
//           );
//         });
//   }
// }

// class BottomMenu extends StatelessWidget {
//   const BottomMenu(
//       {super.key, required this.index, required this.tabcontroller});

//   final int index;
//   final ValueNotifier tabcontroller;

//   @override
//   Widget build(BuildContext context) {
//     // print($})
//     return Container(
//       color: secondaryBackground,
//       height: 90,
//       width: MediaQuery.sizeOf(context).width,
//       child: Padding(
//         padding:
//             const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 TabCalculator.previoustab = tabcontroller.value;
//                 tabcontroller.value = 0;
//               },
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/message.svg",
//                     color: index == 0 ? primaryBackground : Colors.grey,
//                     width: 24,
//                     height: 24,
//                   ),
//                   Text(
//                     "Message",
//                     style: index == 0
//                         ? TextStyleHelper.semiBoldStyle(fontSize: 12)
//                         : TextStyleHelper.semiBoldStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 TabCalculator.previoustab = tabcontroller.value;
//                 tabcontroller.value = 1;
//               },
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/search.svg",
//                     color: index == 1 ? primaryBackground : Colors.grey,
//                     // color: primaryBackground,
//                     width: 24,
//                     height: 24,
//                   ),
//                   Text(
//                     "Search",
//                     style: index == 1
//                         ? TextStyleHelper.semiBoldStyle(fontSize: 12)
//                         : TextStyleHelper.semiBoldStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () async {
//                 showModalBottomSheet(
//                   context: context,
//                   isDismissible: true,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10.sp),
//                       topRight: Radius.circular(10.sp),
//                     ),
//                   ),
//                   isScrollControlled: true,
//                   // barrierColor: transparent,

//                   builder: (context) {
//                     return Container(
//                       padding: const EdgeInsets.all(16),

//                       width: double.infinity,
//                       // height: MediaQuery.sizeOf(context).height < 650
//                       //     ? MediaQuery.sizeOf(context).height * 0.45
//                       //     : MediaQuery.sizeOf(context).height * 0.365,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         color: secondaryBackground,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ListTile(
//                               onTap: () async {
//                                 var cameras = await availableCameras();
//                                 Navigator.pushNamed(
//                                     context, AppRoutes.cameraScreen,
//                                     arguments: CameraPageArgument(
//                                         cameras: cameras,
//                                         fromchatScreen: true));
//                               },
//                               leading: Icon(
//                                 Icons.image,
//                                 color: secondaryTextColor,
//                               ),
//                               title: Text(
//                                 "Image",
//                                 style: TextStyleHelper.mediumStyle(
//                                     color: secondaryTextColor),
//                               )),
//                           ListTile(
//                             leading: Icon(
//                               Icons.text_fields,
//                               color: secondaryTextColor,
//                             ),
//                             title: Text(
//                               "Text",
//                               style: TextStyleHelper.mediumStyle(
//                                   color: secondaryTextColor),
//                             ),
//                             onTap: () async {
//                               Navigator.pushNamed(
//                                   context, AppRoutes.statusuploadpage,
//                                   arguments: StatusUploadPageArg());
//                             },
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   width: 39,
//                   height: 39,
//                   decoration: BoxDecoration(
//                       color: yellowprimary,
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Icon(
//                     Icons.add,
//                     weight: 9,
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 TabCalculator.previoustab = tabcontroller.value;
//                 tabcontroller.value = 2;
//               },
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/phone.svg",
//                     color: index == 2 ? primaryBackground : Colors.grey,
//                     // color: primaryBackground,
//                     width: 24,
//                     height: 24,
//                   ),
//                   Text(
//                     "Status",
//                     style: index == 2
//                         ? TextStyleHelper.semiBoldStyle(fontSize: 12)
//                         : TextStyleHelper.semiBoldStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 TabCalculator.previoustab = tabcontroller.value;
//                 tabcontroller.value = 3;
//               },
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/profile.svg",
//                     color: index == 3 ? primaryBackground : Colors.grey,
//                     // color: primaryBackground,
//                     width: 24,
//                     height: 24,
//                   ),
//                   Text(
//                     "Profile",
//                     style: index == 3
//                         ? TextStyleHelper.semiBoldStyle(fontSize: 12)
//                         : TextStyleHelper.semiBoldStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

enum DashboardTab { chat, search, status, profile }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.lastindex});
  final int lastindex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> tab = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    tab.value = widget.lastindex;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: tab,
      builder: (_, currentTab, __) {
        return Scaffold(
          backgroundColor: primaryBackground,
          body: SafeArea(
            bottom: false,
            child: _buildBody(context, currentTab),
          ),
          bottomSheet: BottomMenu(
            index: currentTab,
            tabController: tab,
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, int tabIndex) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(tabIndex),
            _buildTopContent(tabIndex),
            if (tabIndex != DashboardTab.profile.index)
              _buildBottomContainer(context, tabIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int tabIndex) {
    switch (DashboardTab.values[tabIndex]) {
      case DashboardTab.chat:
        return const WelcomeBackWidget();
      case DashboardTab.search:
        return const SearchTitleWidget();
      case DashboardTab.status:
        return const CallTitleWidget();
      case DashboardTab.profile:
        return const ProfileTitleWidget();
    }
  }

  Widget _buildTopContent(int tabIndex) {
    final isDisabled = tabIndex == DashboardTab.status.index;

    return IgnorePointer(
      ignoring: isDisabled,
      child: switch (DashboardTab.values[tabIndex]) {
        DashboardTab.chat => StatusGridWidget(profile: profile),
        DashboardTab.search => Column(
            children: [
              SearchWidget(),
              SizedBox(height: 10),
            ],
          ),
        DashboardTab.profile => const ProfilePhotoPage(),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildBottomContainer(BuildContext context, int tabIndex) {
    return Container(
      height: MediaQuery.sizeOf(context).height - _calculateHeight(tabIndex),
      decoration: const BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: _buildTabPage(tabIndex),
    );
  }

  Widget _buildTabPage(int tabIndex) {
    switch (DashboardTab.values[tabIndex]) {
      case DashboardTab.chat:
        return ChatListPage(profile: profile);
      case DashboardTab.search:
        return SearchListWidget(profile: profile);
      case DashboardTab.status:
        return const StatusPage();
      default:
        return const SizedBox.shrink();
    }
  }

  double _calculateHeight(int tabIndex) {
    return switch (DashboardTab.values[tabIndex]) {
      DashboardTab.chat => 242,
      DashboardTab.search => 211,
      DashboardTab.status => 137,
      DashboardTab.profile => 147,
    };
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    super.key,
    required this.index,
    required this.tabController,
  });

  final int index;
  final ValueNotifier<int> tabController;

  void _onTabTap(int newIndex) {
    TabCalculator.previoustab = tabController.value;
    tabController.value = newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: secondaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _menuItem("assets/images/message.svg", "Message", 0),
          _menuItem("assets/images/search.svg", "Search", 1),
          _addButton(context),
          _menuItem("assets/images/phone.svg", "Status", 2),
          _menuItem("assets/images/profile.svg", "Profile", 3),
        ],
      ),
    );
  }

  Widget _menuItem(String icon, String label, int tabIndex) {
    final isActive = index == tabIndex;

    return InkWell(
      onTap: () => _onTabTap(tabIndex),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            color: isActive ? primaryBackground : Colors.grey,
          ),
          Text(
            label,
            style: TextStyleHelper.semiBoldStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return InkWell(
      onTap: () => _showAddOptions(context),
      child: Container(
        width: 39,
        height: 39,
        decoration: BoxDecoration(
          color: yellowprimary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _bottomSheetContent(context),
    );
  }

  Widget _bottomSheetContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Image"),
            onTap: () async {
              final cameras = await availableCameras();
              Navigator.pushNamed(
                context,
                AppRoutes.cameraScreen,
                arguments: CameraPageArgument(
                  cameras: cameras,
                  fromchatScreen: true,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text("Text"),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.statusuploadpage,
                arguments: StatusUploadPageArg(),
              );
            },
          ),
        ],
      ),
    );
  }
}

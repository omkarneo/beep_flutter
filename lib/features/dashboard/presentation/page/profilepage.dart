import 'dart:io';

import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/constants/text_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/helpers/socket_helper.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  List<String> status = ["Online", "Offline"];
  late String intialTextselected;

  @override
  void initState() {
    intialTextselected = sharedPrefs.getstatusKey;
    BlocProvider.of<DashboardBloc>(context).add(DashboardProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardProfileState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: NetworkImage(
                            state.profileResponseEntity.data?.photos ??
                                emptyImage),
                        fit: BoxFit.fitHeight)),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.add_circle,
                    color: primaryTextColor,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " ${state.profileResponseEntity.data?.firstName} ${state.profileResponseEntity.data?.lastName}",
                style: TextStyleHelper.boldStyle(
                    fontSize: 30, color: primaryTextColor),
              ),
              Text(
                "+91 ${state.profileResponseEntity.data?.phonenumber}",
                style: TextStyleHelper.lightStyle(
                    fontSize: 19, color: primaryTextColor),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownMenu<String>(
                initialSelection: intialTextselected,
                hintText: "Set Availability",
                trailingIcon: Icon(
                  Icons.arrow_drop_down,
                  color: primaryTextColor,
                  size: 30,
                ),
                leadingIcon: Icon(
                  Icons.co_present_outlined,
                  color: primaryTextColor,
                ),
                label: Text(
                  "Status",
                  style: TextStyleHelper.mediumStyle(color: primaryTextColor),
                ),
                menuStyle: MenuStyle(
                    backgroundColor:
                        WidgetStateProperty.all(secondaryBackground)),

                width: MediaQuery.sizeOf(context).width - 20,
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,

                  // fillColor: primaryTextColor,
                  hintStyle:
                      TextStyleHelper.lightStyle(color: primaryTextColor),
                  // helperStyle:
                ),
                textStyle: TextStyleHelper.boldStyle(color: primaryTextColor),
                // initialSelection: status.first,
                onSelected: (String? value) {
                  if (value == "Offline") {
                    sharedPrefs.setstatusKey("Offline");
                    SocketHelper.logout(
                        state.profileResponseEntity.data?.phonenumber ?? "");
                  } else {
                    sharedPrefs.setstatusKey("Online");
                    SocketHelper.login(
                        state.profileResponseEntity.data?.phonenumber ?? "");
                  }
                  // This is called when the user selects an item.
                  // setState(() {
                  //   status = value;
                  // });
                },
                dropdownMenuEntries:
                    status.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                    // color: secondaryBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileTileWidget(
                        icons: Icons.chat,
                        subtitle: "Check you chat History",
                        title: "Chat",
                      ),
                      ProfileTileWidget(
                        icons: Icons.archive,
                        subtitle: "Find your archived chats",
                        title: "Archived",
                      ),
                      ProfileTileWidget(
                        icons: Icons.person,
                        subtitle: "Change your profile",
                        title: "My Profile",
                      ),
                      ProfileTileWidget(
                        icons: Icons.person,
                        subtitle: "Password and Security",
                        title: "Settings",
                      ),
                      InkWell(
                        onTap: () {
                          sharedPrefs.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.login,
                            (route) => false,
                          );
                        },
                        child: ProfileTileWidget(
                          icons: Icons.person,
                          subtitle: "logout from Application",
                          title: "Logout",
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget(
      {super.key,
      required this.subtitle,
      required this.title,
      required this.icons});
  final String title;
  final String subtitle;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: primaryTextColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icons,
                color: primaryTextColor,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleHelper.boldStyle(
                        fontSize: 16, color: primaryTextColor),
                  ),
                  Text(
                    subtitle,
                    style: TextStyleHelper.mediumStyle(
                        fontSize: 14, color: primaryTextColor),
                  )
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: primaryTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTitleWidget extends StatefulWidget {
  const ProfileTitleWidget({super.key});

  @override
  State<ProfileTitleWidget> createState() => _CallTitleWidgetState();
}

class _CallTitleWidgetState extends State<ProfileTitleWidget> {
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
                  "Profile",
                  style: TextStyleHelper.boldStyle(
                          color: primaryTextColor, fontSize: 30)
                      .copyWith(letterSpacing: -1),
                ),
                IconButton(
                    onPressed: () {
                      sharedPrefs.logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                      color: primaryTextColor,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

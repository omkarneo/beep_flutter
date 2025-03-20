import 'dart:io';

import 'package:chat_app/features/profile_update_page/presentation/bloc/update_profile_bloc.dart';
import 'package:chat_app/utils/constants/color_constants.dart';
import 'package:chat_app/utils/helpers/shared_prefs.dart';
import 'package:chat_app/utils/router/router.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdatePage extends StatefulWidget {
  final String phoneNumber;
  const ProfileUpdatePage({super.key, required this.phoneNumber});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  // TextEditingController photourl = TextEditingController(
  //     text:
  //         "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
  ValueNotifier<File?> photoUpdated = ValueNotifier(null);
  ValueNotifier<String> firstName = ValueNotifier("");
  ValueNotifier<String> lastName = ValueNotifier("");
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryBackground,
      body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboardScreen,
              (route) => false,
            );
          } else if (state is UpdateProfileErrorState) {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: bordercolor,
                textColor: Colors.white,
                fontSize: 14.0);
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileUpdateTitleWidget(),
                ValueListenableBuilder(
                    valueListenable: photoUpdated,
                    builder: (context, value, _) {
                      return Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: value == null
                                  ? NetworkImage(
                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                                  : FileImage(value),
                              onError: (exception, stackTrace) {},
                              fit: BoxFit.fill),
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                ListenableBuilder(
                  listenable: Listenable.merge([firstName, lastName]),
                  builder: (context, child) {
                    return Text(
                      "${firstName.value} ${lastName.value}",
                      style: TextStyleHelper.boldStyle(
                          fontSize: 30, color: primaryTextColor),
                    );
                  },
                ),
                Text(
                  "+91${widget.phoneNumber}",
                  style: TextStyleHelper.lightStyle(
                      fontSize: 19, color: primaryTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: secondaryBackground,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: subtextColors, width: 1)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    final imageTemp = File(image.path);
                                    photoUpdated.value = imageTemp;
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Pick Image",
                                      style: TextStyleHelper.mediumStyle(
                                          color: primaryTextColor),
                                    ),
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: photoUpdated,
                                builder: (context, value, child) {
                                  return value == null
                                      ? SizedBox.shrink()
                                      : Chip(
                                          onDeleted: () {
                                            photoUpdated.value = null;
                                          },
                                          label: SizedBox(
                                            width: 200,
                                            child: Text(
                                              value.path.split("/").last,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            print(value);
                            firstName.value = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              // hintText: "First Name",
                              // label: Text("Enter Your Number"),
                              // labelText: "Enter Your Number",
                              label: Text(
                            "First Name",
                            style: TextStyleHelper.mediumStyle(
                                color: secondaryTextColor),
                          )
                              // border: InputBorder.none,
                              // enabledBorder: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            lastName.value = value;
                          },
                          // controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              // hintText: "Last Name",
                              // label: Text("Enter Your Number"),
                              // labelText: "Enter Your Number",
                              label: Text(
                            "Last Name",
                            style: TextStyleHelper.mediumStyle(
                                color: secondaryTextColor),
                          )
                              // border: InputBorder.none,
                              // enabledBorder: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              // hintText: "Email",
                              // label: Text("Enter Your Number"),
                              // labelText: "Enter Your Number",
                              label: Text(
                            "Email",
                            style: TextStyleHelper.mediumStyle(
                                color: secondaryTextColor),
                          )
                              // border: InputBorder.none,
                              // enabledBorder: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                              ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<UpdateProfileBloc>(context).add(
                                UpdateProfileDataEvent(
                                    email: email.text,
                                    firstName: firstName.value,
                                    lastName: lastName.value,
                                    photourl: photoUpdated.value));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 314.w,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryBackground,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                  child: Text(
                                "Update",
                                style: TextStyleHelper.boldStyle(
                                    fontSize: 16, color: primaryTextColor),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileUpdateTitleWidget extends StatefulWidget {
  const ProfileUpdateTitleWidget({super.key});

  @override
  State<ProfileUpdateTitleWidget> createState() => _CallTitleWidgetState();
}

class _CallTitleWidgetState extends State<ProfileUpdateTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile Update",
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

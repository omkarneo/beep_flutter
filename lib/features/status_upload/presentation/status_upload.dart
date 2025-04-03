import 'dart:io';

import 'package:beep/features/status_upload/presentation/bloc/status_upload_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/extensions/snackbar_extention.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class StatusUploadPage extends StatefulWidget {
  const StatusUploadPage({super.key, this.image});
  final XFile? image;

  @override
  State<StatusUploadPage> createState() => _StatusUploadPageState();
}

class _StatusUploadPageState extends State<StatusUploadPage> {
  TextEditingController statuscontroller = TextEditingController(text: "");
  @override
  void initState() {
    BlocProvider.of<StatusUploadBloc>(context).add(StatusResetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StatusUploadBloc, StatusUploadState>(
        listener: (context, state) {
          if (state is StatusUploadedState) {
            Navigator.pushNamed(context, AppRoutes.dashboardScreen,
                arguments: 2);
          }
          if (state is StatusErrorState) {
            context.errorSnackBar("Something went wrong");
            Navigator.pushNamed(context, AppRoutes.dashboardScreen,
                arguments: 2);
          }
        },
        child: Container(
          color: yellowprimary,
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
              widget.image != null
                  ? Expanded(
                      flex: 3, child: Image.file(File(widget.image!.path)))
                  : SizedBox.shrink(),
              Expanded(
                  child: Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    controller: statuscontroller,
                    cursorColor: Colors.white,
                    style: TextStyleHelper.boldStyle(
                        color: Colors.white, fontSize: 30),
                    decoration: InputDecoration(
                        hintText: "Type a Status",
                        hintStyle: TextStyleHelper.boldStyle(
                            color: Colors.white, fontSize: 30),
                        hoverColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.dashboardScreen, (route) => false,
                          arguments: 2);
                    },
                    child: Container(
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "Cancel",
                        style:
                            TextStyleHelper.boldStyle(color: primaryBackground),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<StatusUploadBloc>(context).add(
                          UploadStatusServerEvent(
                              image: widget.image,
                              stausMessage: statuscontroller.text));
                    },
                    child: Container(
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "Upload",
                        style:
                            TextStyleHelper.boldStyle(color: primaryBackground),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

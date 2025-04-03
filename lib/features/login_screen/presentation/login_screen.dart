// ignore_for_file: use_build_context_synchronously

import 'package:beep/features/login_screen/presentation/bloc/login_screen_bloc.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/helpers/shared_prefs.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final countryPicker = const FlCountryCodePicker();
  ValueNotifier<bool> onsubmit = ValueNotifier(true);
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  FocusNode otp1focus = FocusNode();
  FocusNode otp2focus = FocusNode();
  FocusNode otp3focus = FocusNode();
  FocusNode otp4focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryBackground,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Welcome to BEEP",
                  style: TextStyleHelper.boldStyle(
                      fontSize: 30, color: primaryTextColor),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: secondaryBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              // ccholor: secondaryBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<LoginScreenBloc, LoginScreenState>(
                        listener: (context, state) async {
                      if (state is OtpScreenState) {
                        onsubmit.value = true;
                        Fluttertoast.showToast(
                            msg: "OTP has been Send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: bordercolor,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }

                      if (state is SuccessState) {
                        if (state.isexpired == false) {
                          await sharedPrefs.setAuthToken(state.token);
                          if (state.newaccount) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.profileUpdate,
                              arguments: phoneNumber.text,
                              (route) => false,
                            );
                          } else {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.dashboardScreen,
                              arguments: 0,
                              (route) => false,
                            );
                          }
                        }
                        BlocProvider.of<LoginScreenBloc>(context)
                            .add(ResetEvent());
                      }
                    }, builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: bordercolor,
                                borderRadius: BorderRadius.circular(20)),
                            // color: ,
                            width: 100,
                            height: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(19.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (state is MoblieNumberScreenState)
                                        ? "Enter Your Moblie Number"
                                        : "Enter OTP",
                                    style:
                                        TextStyleHelper.boldStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (state is MoblieNumberScreenState)
                                        ? "Please confirm your Country Code and Enter you moblie Number"
                                        : "Please check your SMS app For otp",
                                    style: TextStyleHelper.regularStyle(
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          (state is MoblieNumberScreenState)
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    // width: 350,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: bordercolor,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              final code = await countryPicker
                                                  .showPicker(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      backgroundColor:
                                                          secondaryBackground,
                                                      pickerMaxHeight:
                                                          MediaQuery.sizeOf(
                                                                      context)
                                                                  .height /
                                                              1.7,
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                        side: BorderSide(
                                                            color:
                                                                primaryBackground),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20)),
                                                      ),
                                                      context: context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primaryBackground),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Text(
                                                        "+91",
                                                        style: TextStyleHelper
                                                            .boldStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    primaryTextColor),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: TextFormField(
                                              controller: phoneNumber,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "Moblie Number",
                                                // label: Text("Enter Your Number"),
                                                // labelText: "Enter Your Number",

                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryBackground,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: TextFormField(
                                            focusNode: otp1focus,
                                            onChanged: (value) =>
                                                otp2focus.nextFocus(),
                                            textAlign: TextAlign.center,
                                            // controller: phoneNumber,
                                            keyboardType: TextInputType.number,
                                            maxLength: 1,
                                            style: TextStyleHelper.boldStyle(),
                                            controller: otp1,

                                            decoration: InputDecoration(
                                              hintText: "",
                                              // label: Text("Enter Your Number"),
                                              // labelText: "Enter Your Number",

                                              border: InputBorder.none,

                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryBackground,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) =>
                                                otp3focus.nextFocus(),
                                            focusNode: otp2focus,
                                            textAlign: TextAlign.center,
                                            // controller: phoneNumber,
                                            controller: otp2,
                                            keyboardType: TextInputType.number,
                                            maxLength: 1,
                                            style: TextStyleHelper.boldStyle(),
                                            decoration: InputDecoration(
                                              hintText: "",
                                              // label: Text("Enter Your Number"),
                                              // labelText: "Enter Your Number",

                                              border: InputBorder.none,

                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryBackground,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) =>
                                                otp4focus.nextFocus(),
                                            focusNode: otp3focus,
                                            textAlign: TextAlign.center,
                                            controller: otp3,
                                            // controller: phoneNumber,
                                            keyboardType: TextInputType.number,
                                            maxLength: 1,
                                            style: TextStyleHelper.boldStyle(),
                                            decoration: InputDecoration(
                                              hintText: "",
                                              // label: Text("Enter Your Number"),
                                              // labelText: "Enter Your Number",

                                              border: InputBorder.none,

                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryBackground,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: TextFormField(
                                            focusNode: otp4focus,
                                            textAlign: TextAlign.center,
                                            // controller: phoneNumber,
                                            controller: otp4,
                                            keyboardType: TextInputType.number,
                                            maxLength: 1,
                                            style: TextStyleHelper.boldStyle(),
                                            decoration: InputDecoration(
                                              hintText: "",
                                              // label: Text("Enter Your Number"),
                                              // labelText: "Enter Your Number",

                                              border: InputBorder.none,

                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ValueListenableBuilder(
                              valueListenable: onsubmit,
                              builder: (context, value, _) {
                                return InkWell(
                                  onTap: value == false
                                      ? null
                                      : () {
                                          if (state
                                              is MoblieNumberScreenState) {
                                            if (phoneNumber.text.isNotEmpty) {
                                              print("asfasf moblie");
                                              onsubmit.value = false;
                                              BlocProvider.of<LoginScreenBloc>(
                                                      context)
                                                  .add(EntryEvent(
                                                      number:
                                                          phoneNumber.text));
                                            }
                                          } else {
                                            onsubmit.value = false;

                                            BlocProvider.of<LoginScreenBloc>(
                                                    context)
                                                .add(OtpEvent(
                                                    number: phoneNumber.text,
                                                    otp: "1234".toString()));
                                            // Navigator.pushNamedAndRemoveUntil(
                                            //   context,
                                            //   AppRoutes.dashboardScreen,
                                            //   (route) => false,
                                            // );
                                          }

                                          // Navigator.pushNamed(context, AppRoutes.login);
                                        },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 314.w,
                                      height: 64,
                                      decoration: BoxDecoration(
                                          color: primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                          child: Text(
                                        (state is MoblieNumberScreenState)
                                            ? "Get OTP"
                                            : "Verify",
                                        style: TextStyleHelper.boldStyle(
                                            fontSize: 16,
                                            color: primaryTextColor),
                                      )),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyleHelper.regularStyle(
                                  color: secondaryTextColor, fontSize: 14),
                              text:
                                  "by Providing phone number, i hereby agree and accepts the ",
                              children: [
                                TextSpan(
                                    text: "Terms and Conditions",
                                    style: TextStyleHelper.boldStyle().copyWith(
                                        decoration: TextDecoration.underline),
                                    children: [
                                      TextSpan(
                                          text: " and ",
                                          style: TextStyleHelper.regularStyle(
                                                  color: secondaryTextColor,
                                                  fontSize: 14)
                                              .copyWith(
                                                  decoration:
                                                      TextDecoration.none),
                                          children: [
                                            TextSpan(
                                                text: "Privacy Policy",
                                                style:
                                                    TextStyleHelper.boldStyle()
                                                        .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          " in use of BEEP app",
                                                      style: TextStyleHelper
                                                              .regularStyle(
                                                                  color:
                                                                      secondaryTextColor,
                                                                  fontSize: 14)
                                                          .copyWith(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none))
                                                ])
                                          ])
                                    ])
                              ])),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

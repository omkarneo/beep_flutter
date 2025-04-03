import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/constants/image_constants.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Center(
                child: Text(
                  "BEEP",
                  style: TextStyleHelper.boldStyle(
                      fontSize: 36, color: primaryTextColor),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 50.h, right: 100, left: 20, bottom: 24),
              child: SvgPicture.asset(
                onBoardingScreenImage,
                width: 279,
                height: 225,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Stay connected with your friends and family",
                style: TextStyleHelper.boldStyle(
                    fontSize: 36, color: primaryTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20.0),
              child: Row(
                children: [
                  SvgPicture.asset(sheildlogo),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Secure, private messaging",
                    style: TextStyleHelper.boldStyle(
                        fontSize: 16.sp, color: primaryTextColor),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  width: 314.w,
                  height: 64,
                  decoration: BoxDecoration(
                      color: secondaryBackground,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    "Get Started",
                    style: TextStyleHelper.boldStyle(fontSize: 16),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

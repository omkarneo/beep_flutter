import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SizedBox(
            height: 300,
            child: Center(
              child: Lottie.asset(
                "assets/animation/no_internet_lottie.json",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("You're Offline",
              style: TextStyleHelper.boldStyle(fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Text("Please Connect to internet and try again",
              style:
                  TextStyleHelper.lightStyle(color: bordercolor, fontSize: 15)),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.root);
            },
            child: Container(
              width: 150,
              height: 60,
              decoration: BoxDecoration(
                  color: primaryBackground,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "Retry",
                  style: TextStyleHelper.boldStyle(color: primaryTextColor),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

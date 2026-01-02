import 'package:beep/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class PageHandle extends StatelessWidget {
  const PageHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 15),
        _HandleBar(),
        SizedBox(height: 15),
      ],
    );
  }
}

class _HandleBar extends StatelessWidget {
  const _HandleBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 5,
      decoration: BoxDecoration(
        color: chatlistdashcolor,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

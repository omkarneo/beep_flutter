import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

extension SnackBarExt on BuildContext {
  void snackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: yellowprimary,
          content: Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: TextStyleHelper.mediumStyle(color: primaryTextColor),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void errorSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(message, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void successSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.green,
          content: Text(message, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}

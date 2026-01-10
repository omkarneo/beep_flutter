import 'package:flutter/material.dart';

bottomSheetContent(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return child;
    },
    // builder: (_) => child()
  );
}

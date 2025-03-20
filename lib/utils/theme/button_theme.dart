
import 'package:flutter/material.dart';

class ButtonStyleHelper{

  static ButtonStyle _getButtonStyle(Color color,){
    return  ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(color),
      shape: const WidgetStatePropertyAll(BeveledRectangleBorder())
      // foregroundColor: WidgetStatePropertyAll(tex)
    );
  }
}
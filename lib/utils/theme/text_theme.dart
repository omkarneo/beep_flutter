import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleHelper {
  static TextStyle _getTextStyle(double? fontSize, FontWeight fontWeight,
      Color? color, FontStyle fontStyle) {
    return GoogleFonts.montserrat(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle lightStyle(
      {double? fontSize,
        required Color color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w300, color, fontStyle);
  }

  static TextStyle regularStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w400, color, fontStyle);
  }

  static TextStyle italicStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.italic}) {
    return _getTextStyle(fontSize, FontWeight.w400, color, fontStyle);
  }

  static TextStyle mediumStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w500, color, fontStyle);
  }

  static TextStyle semiBoldStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w600, color, fontStyle);
  }

  static TextStyle boldStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w700, color, fontStyle);
  }
}

/*class TextStyleHelper {
  static TextStyle _getTextStyle(double? fontSize, FontWeight fontWeight,
      Color? color, FontStyle fontStyle) {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle lightStyle(
      {double? fontSize,
        required Color color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w300, color, fontStyle);
  }

  static TextStyle regularStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w400, color, fontStyle);
  }

  static TextStyle italicStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.italic}) {
    return _getTextStyle(fontSize, FontWeight.w400, color, fontStyle);
  }

  static TextStyle mediumStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w500, color, fontStyle);
  }

  static TextStyle semiBoldStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w600, color, fontStyle);
  }

  static TextStyle boldStyle(
      {double? fontSize,
        Color? color,
        FontStyle fontStyle = FontStyle.normal}) {
    return _getTextStyle(fontSize, FontWeight.w700, color, fontStyle);
  }
}*/

/// Custom textTheme. Either use this or the above one for the styling the text. Remove code later on if not using this
final TextTheme textTheme = TextTheme(
  titleLarge: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),

  // title2
  titleMedium: GoogleFonts.openSans(fontSize: 32, fontWeight: FontWeight.w400),

  // Body1
  bodyLarge: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600),

  // Body2
  bodyMedium: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400),

  // Body3
  bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
);

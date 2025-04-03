import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Light Theme Related Data
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: GoogleFonts.interTextTheme(
        // Theme.of(context).textTheme,
        ),

    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryBackground,
    ),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,

      helperStyle: const TextStyle(fontSize: 0),
      // errorStyle:
      // TextStyleHelper.regularStyle(fontSize: 12.sp, color: errorRed),
      contentPadding: EdgeInsets.only(left: 8.w, top: 8.5.h, bottom: 8.5.h),
      border: OutlineInputBorder(
          // borderSide: const BorderSide(color: greyInputBorder),
          borderRadius: BorderRadius.circular(8.r)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryBackground),
          borderRadius: BorderRadius.circular(8.r)),
      focusedErrorBorder: OutlineInputBorder(
          // borderSide: const BorderSide(color: errorRed, width: 1),
          borderRadius: BorderRadius.circular(8.r)),
      errorBorder: OutlineInputBorder(
          // borderSide: const BorderSide(color: errorRed, width: 1),
          borderRadius: BorderRadius.circular(8.r)),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBackground,
    ),
  );
//
//   /// Dark Theme Related Data
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     appBarTheme: AppBarTheme(
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//     // textSelectionTheme: TextSelectionThemeData(cursorColor: primaryGreen),
//     inputDecorationTheme: InputDecorationTheme(
//       isDense: true,
//       helperStyle: const TextStyle(fontSize: 0),
//       errorStyle:
//       TextStyleHelper.regularStyle(fontSize: 12.sp, color: errorRed),
//       contentPadding: EdgeInsets.only(left: 8.w, top: 8.5.h, bottom: 8.5.h),
//       border: OutlineInputBorder(
//           borderSide: const BorderSide(color: greyInputBorder),
//           borderRadius: BorderRadius.circular(8.r)),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: primaryGreen),
//           borderRadius: BorderRadius.circular(8.r)),
//       focusedErrorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: errorRed, width: 1),
//           borderRadius: BorderRadius.circular(8.r)),
//       errorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: errorRed, width: 1),
//           borderRadius: BorderRadius.circular(8.r)),
//     ),
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: primaryGreen,
//       brightness: Brightness.dark,
//     ),
//   );
// }

  /// Use this ColorSchemes later on if required, remove code if not required
// ColorScheme lightColorScheme = const ColorScheme(
//   brightness: Brightness.light,
//   primary: Color(0xFF039849),
//   onPrimary: Color(0xFFFFFFFF),
//   secondary: Color(0xFFA6CE3A),
//   onSecondary: Color(0xFFFFFFFF),
//   error: Color(0xFFB3261E),
//   onError: Color(0xFFFFFFFF),
//   background: Color(0xFFFFFBFE),
//   onBackground: Color(0xFF1C1B1F),
//   surface: Color(0xFFFFFBFE),
//   onSurface: Color(0xFF1C1B1F),
// );

// ColorScheme darkColorScheme = const ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFFD0BCFF),
//   onPrimary: Color(0xFF381E72),
//   secondary: Color(0xFFCCC2DC),
//   onSecondary: Color(0xFF332D41),
//   error: Color(0xFFF2B8B5),
//   onError: Color(0xFF601410),
//   errorContainer: Color(0xFF8C1D18),
//   background: Color(0xFF1C1B1F),
//   onBackground: Color(0xFFE6E1E5),
//   surface: Color(0xFF1C1B1F),
//   onSurface: Color(0xFFE6E1E5),
// );
}

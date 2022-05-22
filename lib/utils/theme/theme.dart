import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photos_app/utils/theme/colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: mainClr,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: mainClr,
    fontFamily: 'Ubuntu',
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: mainClr,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: whiteClr,
      unselectedItemColor: secondClr,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: mainClr,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: whiteClr,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Ubuntu',
      ),
    ),
  );
}

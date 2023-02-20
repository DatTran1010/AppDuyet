import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viet_soft/UI/constants/colors.dart';

class VietSoftTheme {
  VietSoftTheme._();
  static final ThemeData lightTheme = ThemeData(
      backgroundColor: VietSoftColor.lightTheme,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)));

  static final ThemeData darkTheme = lightTheme;
}

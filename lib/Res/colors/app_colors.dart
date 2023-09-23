import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xff90B2F9);
  static Color secondaryColor = const Color(0xff90B2F8);
  static Color black = const Color(0xff030303);
  static Color white = const Color(0xffffffff);
  static Color readableContent = const Color(0xffa8a8a8);
  static Color errorBorder = const Color(0xffff5a7b);
  static Color error = const Color(0xffff0026);
  static Color skillsContainer = const Color(0xff96d7fc);
  //Create a shader linear gradient
  static Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Res/colors/app_colors.dart';

class AppTextStyles {
  static TextStyle headerTextStyle({Color color = Colors.white, double fontSize = 18}) {
    return GoogleFonts.signikaNegative(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle montserratStyle(
      {required Color color, required double fontSize}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
  }

  static TextStyle normalStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      letterSpacing: 1.7,
      height: 1.5,
    );
  }

  static TextStyle splashStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
      letterSpacing: 3.5,
      height: 1.5,
    );
  }

  static TextStyle readableStyle(double fontSize) {
    return GoogleFonts.rubik(
        letterSpacing: 1,
        fontSize: fontSize, color: AppColors.readableContent);
  }
}

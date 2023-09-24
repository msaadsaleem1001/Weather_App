import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Res/Routes/app_routes.dart';
import 'package:weather_app/Res/colors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        popupMenuTheme: PopupMenuThemeData(
            enableFeedback: false,
            elevation: 0.0,
            surfaceTintColor: AppColors.white,
            position: PopupMenuPosition.under),
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

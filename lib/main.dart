import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Res/GetX%20Localization/app_localization.dart';
import 'package:weather_app/Res/Routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Tutorials',
      // Under three lines that are used to add localization
      translations: Languages(),
      locale: const Locale('en', 'Us'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const GetStarted(),
      getPages: AppRoutes.appRoutes(),
      //Defining routes this way in GetX
      // getPages: [
      //   GetPage(name: "/", page: () => const FirstScreen()),//First Screen will be forward slash
      //   GetPage(name: "/secondScreen", page: () => SecondScreen()),
      // ],
    );
  }
}



import 'package:get/get.dart';
import 'package:weather_app/Res/Routes/routes_names.dart';
import 'package:weather_app/view/detail_page.dart';
import 'package:weather_app/view/home.dart';
import 'package:weather_app/view/search_view.dart';
import 'package:weather_app/view/selection.dart';
import 'package:weather_app/view/splash_view.dart';

class AppRoutes{

  static appRoutes() => [

    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: RouteNames.homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: RouteNames.detailScreen,
      page: () => const DetailScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: RouteNames.searchScreen,
      page: () => const CitySearch(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: RouteNames.selectionScreen,
      page: () => const SelectionScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

  ];

}
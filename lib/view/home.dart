// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Network%20Connectivity/connectivity_checker.dart';
import 'package:weather_app/Res/Components/error_widget.dart';
import 'package:weather_app/Res/Components/weather_item.dart';
import 'package:weather_app/Res/Routes/routes_names.dart';
import 'package:weather_app/Res/assets/app_assets.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/ViewModel/HomeModal/home_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeModal = Get.put(HomeModal());

  @override
  void initState() {
    homeModal.selectedCity.value = homeModal.userList[0].cityName;
    homeModal.getWeatherForSpecific(
        homeModal.userList[0].lat, homeModal.userList[0].lon);
    homeModal.getWeatherForeCast(
        homeModal.userList[0].lat, homeModal.userList[0].lon);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the media query
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    Connectivity connectivity =  Connectivity() ;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  AppAssets.profile,
                  width: 40,
                  height: 40,
                ),
              ),
              //our location dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.pin,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Obx(() => PopupMenuButton(
                      onSelected: (val) {
                        if (val == homeModal.userList.length) {
                          Get.back();
                          Get.toNamed(RouteNames.selectionScreen);
                        } else {
                          homeModal.selectedCity.value =
                              homeModal.userList[val].cityName;
                          homeModal.getWeatherForSpecific(
                              homeModal.userList[val].lat,
                              homeModal.userList[val].lon);
                          homeModal.getWeatherForeCast(
                              homeModal.userList[val].lat,
                              homeModal.userList[val].lon);
                        }
                      },
                      enableFeedback: false,
                      itemBuilder: (context) {
                        return List.generate(
                          homeModal.userList.length + 1,
                          (index) => PopupMenuItem(
                              value: index,
                              child: ListTile(
                                title: index == homeModal.userList.length
                                    ? const Text('Select Location')
                                    : Text(homeModal.userList[index].cityName),
                              )),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            homeModal.selectedCity.value,
                            style: AppTextStyles.headerTextStyle(
                                color: AppColors.black),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Obx( () =>
      homeModal.rxStatusCode == Status.LOADING
          ? const Center(child: CircularProgressIndicator())
          : homeModal.rxStatusCode == Status.COMPLETED
          ? Stack(
        children: [
          Positioned(
              top: 0,
              child: StreamBuilder<ConnectivityResult>(
                stream: connectivity.onConnectivityChanged,
                builder: (_, snapshot){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CheckInternetConnectionWidget(
                      snapshot: snapshot,
                      widget: const SizedBox(),
                    ),
                  ) ;
                },
              ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: height * .02,
              left: width * .05,
              right: width * .05,
              bottom: height * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(homeModal.currentWeather[0].name,
                    style: AppTextStyles.montserratStyle(
                        color: AppColors.black, fontSize: 16))),
                Obx(() => Text(
                    '${homeModal.currentWeather[0].region}, ${homeModal.currentWeather[0].country}',
                    style: AppTextStyles.readableStyle(14))),
                Obx(() => Text(
                  'Last Updated: ${homeModal.currentWeather[0].lastUpdated}',
                  style: AppTextStyles.readableStyle(14),
                )),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  width: width,
                  height: height * .25,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color:
                          AppColors.primaryColor.withOpacity(.5),
                          offset: const Offset(0, 25),
                          blurRadius: 10,
                          spreadRadius: -12,
                        )
                      ]),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(() => Positioned(
                        top: 0,
                        left: 10,
                        child: homeModal
                            .currentWeather[0].icon.isEmpty
                            ? const SizedBox()
                            : Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https:${homeModal.currentWeather[0].icon}'),
                                fit: BoxFit.fill,
                              )),
                        ),
                      )),
                      Obx(() => Positioned(
                        bottom: 30,
                        left: 20,
                        child: Text(
                            homeModal.currentWeather[0].text,
                            style: AppTextStyles.montserratStyle(
                                color: AppColors.white,
                                fontSize: 20)),
                      )),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 4.0),
                              child: Obx(() => Text(
                                homeModal.currentWeather[0].tempC,
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader =
                                        AppColors.linearGradient,
                                ),
                              )),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = AppColors.linearGradient,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => WeatherItem(
                          text: 'Wind Speed',
                          value: homeModal.currentWeather[0].windKph,
                          unit: 'km/h',
                          imageUrl: AppAssets.windSpeed)),
                      Obx(() => WeatherItem(
                          text: 'Humidity',
                          value: homeModal.currentWeather[0].humidity,
                          unit: '',
                          imageUrl: AppAssets.humidity)),
                      Obx(() => WeatherItem(
                        text: 'Max Temp',
                        value:
                        homeModal.currentWeather[0].maxTempC,
                        unit: 'C',
                        imageUrl: AppAssets.maxTemp,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Today',
                        style: AppTextStyles.readableStyle(16)),
                    Text('Next 21 Days',
                        style: AppTextStyles.readableStyle(16)),
                  ],
                ),
                Obx(() => Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeModal.foreCast.length,
                        itemBuilder: (context, index) {
                          return Obx(() => GestureDetector(
                            onTap: () {
                              homeModal.selectedIndex.value =
                                  index;
                              homeModal.windSpeed.value =
                                  homeModal.foreCast[index]
                                      .windSpeedMph;
                              homeModal.humidity.value = homeModal
                                  .foreCast[index].humidity;
                              homeModal.temp.value =
                                  homeModal.foreCast[index].tempF;
                              homeModal.maxTemp.value = homeModal
                                  .foreCast[index].tempMax;
                              homeModal.imageSelected.value =
                                  homeModal.weatherImg[homeModal
                                      .foreCast[index].weather
                                      .toString()]
                                      .toString();
                              Get.toNamed(
                                  RouteNames.detailScreen);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              margin: const EdgeInsets.only(
                                  right: 20, bottom: 10, top: 10),
                              width: width * .3,
                              decoration: BoxDecoration(
                                  color: index == 0
                                      ? AppColors.primaryColor
                                      : AppColors.white,
                                  borderRadius:
                                  const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      color: index == 0
                                          ? AppColors.primaryColor
                                          : Colors.black54
                                          .withOpacity(.2),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                      '${homeModal.foreCast[index].tempF}C',
                                      style: AppTextStyles
                                          .montserratStyle(
                                          color: index == 0
                                              ? Colors.white
                                              : AppColors
                                              .primaryColor,
                                          fontSize: 16)),
                                  Image.asset(
                                    homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())
                                        ?homeModal.weatherImg[homeModal.foreCast[index].weather.toString()].toString()
                                        :AppAssets.errorImage,
                                    width: homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())? 50 : 20,
                                    height: homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())? 50 : 20,
                                  ),
                                  Text(
                                      homeModal
                                          .foreCast[index].date,
                                      style: AppTextStyles
                                          .montserratStyle(
                                          color: index == 0
                                              ? Colors.white
                                              : AppColors
                                              .primaryColor,
                                          fontSize: 10))
                                ],
                              ),
                            ),
                          ));
                        }))),
              ],
            ),
          )
        ],
      )
          : ExceptionWidget(
        msg: homeModal.errorMessage.value,
        retry: () {
          homeModal.selectedCity.value = homeModal.userList[0].cityName;
          homeModal.getWeatherForSpecific(
              homeModal.userList[0].lat, homeModal.userList[0].lon);
          homeModal.getWeatherForeCast(
              homeModal.userList[0].lat, homeModal.userList[0].lon);
        },
      ),
      ),
    );
  }
}

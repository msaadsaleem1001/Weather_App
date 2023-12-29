
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Res/Components/weather_item.dart';
import 'package:weather_app/Res/assets/app_assets.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/ViewModel/HomeModal/home_modal.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final homeModal = Get.put(HomeModal());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0.0,
        title: Obx(() => Text(homeModal.selectedCity.value, style: AppTextStyles.headerTextStyle(
          color: AppColors.white,
          fontSize: 25
        ))),
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: height * .15,
              width: width,
              child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeModal.foreCast.length,
                  itemBuilder: (context, index) {
                    return Obx(() => InkWell(
                      enableFeedback: false,
                      onTap: (){
                        homeModal.selectedIndex.value = index;
                        homeModal.windSpeed.value = homeModal.foreCast[index].windSpeedMph;
                        homeModal.humidity.value = homeModal.foreCast[index].humidity;
                        homeModal.temp.value = homeModal.foreCast[index].tempF;
                        homeModal.maxTemp.value = homeModal.foreCast[index].tempMax;
                        homeModal.imageSelected.value = homeModal.weatherImg[homeModal.foreCast[index].weather.toString()].toString();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(right: 20),
                        width: width * .3,
                        decoration: BoxDecoration(
                            color: index == homeModal.selectedIndex.value
                                ? Colors.white
                                : const Color(0xff9ebcf9),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.blue.withOpacity(.3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                "${homeModal.foreCast[index].tempF} C",
                                style: AppTextStyles.montserratStyle(
                                    color: index == homeModal.selectedIndex.value
                                        ? Colors.blue
                                        : Colors.white,
                                    fontSize: 16)
                            )),
                            Obx(() => Image.asset(
                              homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())
                                  ?homeModal.weatherImg[homeModal.foreCast[index].weather.toString()].toString()
                                  :AppAssets.errorImage,
                              width: homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())? 50 : 20,
                              height: homeModal.weatherImg.containsKey(homeModal.foreCast[index].weather.toString())? 50 : 20,
                            ),),
                            Obx(() => Text(
                                homeModal.foreCast[index].date,
                                style: AppTextStyles.montserratStyle(
                                    color: index == homeModal.selectedIndex.value
                                        ? Colors.blue
                                        : Colors.white,
                                    fontSize: 10)
                            )),
                          ],
                        ),
                      ),
                    ));
                  })),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: height * .6,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      width: width,
                      height: height * .35,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 25),
                              blurRadius: 3,
                              spreadRadius: -10,
                            ),
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() => Positioned(
                            top: -30,
                            left: 20,
                            child: Image.asset(
                              homeModal.imageSelected.toString(),
                              width: 120,
                              height: 120,
                            ),
                          )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => WeatherItem(
                                    text: 'Wind Speed',
                                    value: homeModal.windSpeed.value,
                                    unit: 'MPH',
                                    imageUrl: AppAssets.windSpeed,
                                  )),
                                  Obx(() => WeatherItem(
                                      text: 'Humidity',
                                      value: homeModal.humidity.value,
                                      unit: '',
                                      imageUrl: AppAssets.humidity)),
                                  Obx(() => WeatherItem(
                                    text: 'Max Temp',
                                    value: homeModal.maxTemp.value,
                                    unit: 'C',
                                    imageUrl: AppAssets.maxTemp,
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                  '${homeModal.temp.value}C',
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = AppColors.linearGradient,
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: SizedBox(
                        width: width,
                        height: height * .27,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: homeModal.foreCast.length,
                            itemBuilder: (context, index) {
                              return Obx(() => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 50,
                                width: width,
                                decoration: BoxDecoration(
                                    color: homeModal.selectedIndex.value == index
                                        ?AppColors.primaryColor
                                        :AppColors.primaryColor.withOpacity(.2),
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors
                                            .secondaryColor
                                            .withOpacity(.1),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          homeModal.foreCast[index].date,
                                          style: homeModal.selectedIndex.value == index
                                              ?AppTextStyles.montserratStyle(
                                              color: AppColors.white,
                                              fontSize: 12)
                                              :AppTextStyles.readableStyle(12),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              '${homeModal.foreCast[index].tempMin}C',
                                              style: homeModal.selectedIndex.value == index
                                                  ?AppTextStyles.montserratStyle(
                                                  color: AppColors.white,
                                                  fontSize: 14)
                                                  :AppTextStyles.readableStyle(14),

                                          ),
                                          Text(
                                              '/',
                                              style: homeModal.selectedIndex.value == index
                                                  ?AppTextStyles.montserratStyle(
                                                  color: AppColors.white,
                                                  fontSize: 16)
                                                  :AppTextStyles.readableStyle(16),
                                          ),
                                          Text(
                                              '${homeModal.foreCast[index].tempMax}C',
                                              style: homeModal.selectedIndex.value == index
                                                  ?AppTextStyles.montserratStyle(
                                                  color: AppColors.white,
                                                  fontSize: 16)
                                                  :AppTextStyles.readableStyle(16),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        homeModal.foreCast[index].weather == ''
                                            ?AppAssets.clear
                                            : homeModal.weatherImg[homeModal.foreCast[index].weather.toString()].toString(),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            }),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Models/Weather%20Modal/current_weather_modal.dart';
import 'package:weather_app/Models/Weather%20Modal/forecast_weather_modal.dart';
import 'package:weather_app/Models/database_modal.dart';
import 'package:weather_app/Repository/Weather%20Repository/city_weather.dart';
import 'package:weather_app/Res/assets/app_assets.dart';

class HomeModal extends GetxController{

  final weatherRepository = CityWeatherRepository();

  final rxStatusCode = Status.LOADING.obs;
  RxString errorMessage = 'Error'.obs;
  RxString selectedCity = ''.obs;
  RxInt selectedIndex = 0.obs;
  RxString windSpeed = ''.obs;
  RxString humidity = ''.obs;
  RxString temp = ''.obs;
  RxString maxTemp = ''.obs;
  RxString imageSelected = ''.obs;

  Map<String, String> weatherImg = {
    'partly_sunny': AppAssets.partially,
    'cloudy': AppAssets.lightCloud,
    'mostly_cloudy': AppAssets.heavyCloud,
    'mostly_sunny': AppAssets.clear,
    'sunny': AppAssets.clear,
    'psbl_rain': AppAssets.showers,
    'overcast': AppAssets.overcast,
    'rain_shower': AppAssets.rainShower,
    'light_rain': AppAssets.lightRain,
    'rain': AppAssets.rain
  };

  void setRxStatusCode(Status value) => rxStatusCode.value = value;

  RxList<DatabaseCityModal> userList = [
    DatabaseCityModal(
        cityName: '',
        countryCode: '',
        lat: '',
        lon: '',
        isDefault: false,
        isSelected: false
    )].obs;

  RxList<CurrentWeatherModal> currentWeather = [
    CurrentWeatherModal(
        name: 'Loading...',
        region: '',
        country: '',
        lastUpdated: 'Loading...',
        tempC: '0.0',
        maxTempF: '0.0',
        tempF: '0.0',
        maxTempC: '0.0',
        isDay: false,
        text: '',
        icon: '',
        windMph: '0.0',
        windKph: '0.0',
        windDegree: '0.0',
        windDir: '0.0',
        humidity: '0.0'
    )
  ].obs;

  RxList<ForeCastWeatherModal> foreCast = [
    ForeCastWeatherModal(
        date: '',
        weather: '',
        summary: '',
        tempF: '0.0',
        tempMin: '0.0',
        tempMax: '0.0',
        windSpeedMph: '0.0',
        windAngle: '0.0',
        windDir: '',
        humidity: '0.0'
    )
  ].obs;


  void getWeatherForSpecific(String lat, String lon){
    weatherRepository.getCityWeather(lat, lon).then((value) {
      setRxStatusCode(Status.COMPLETED);
      currentWeather.clear();
      currentWeather.add(
          CurrentWeatherModal(
              name: value['location']['name'],
              region: value['location']['region'],
              country: value['location']['country'],
              lastUpdated: value['current']['last_updated'],
              tempC: value['current']['temp_c'].toString(),
              maxTempC: value['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
              tempF: value['current']['temp_f'].toString(),
              maxTempF: value['forecast']['forecastday'][0]['day']['maxtemp_f'].toString(),
              isDay: value['current']['is_day'] == 1? true : false,
              text: value['current']['condition']['text'],
              icon: value['current']['condition']['icon'],
              windMph: value['current']['wind_mph'].toString(),
              windKph: value['current']['wind_kph'].toString(),
              windDegree: value['current']['wind_degree'].toString(),
              windDir: value['current']['wind_dir'],
              humidity: value['current']['humidity'].toString()));
      debugPrint('Json result: ${currentWeather[0].maxTempC}');
    }).onError((error, stackTrace) {
      setRxStatusCode(Status.ERROR);
      errorMessage.value = error.toString();
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  void getWeatherForeCast(String lat, String lon){
    weatherRepository.getForeCastWeather(lat, lon).then((value) {
      setRxStatusCode(Status.COMPLETED);
      foreCast.clear();
      for(var val in value['daily']['data']){
        // debugPrint(val['weather'].toString());
        foreCast.add(
            ForeCastWeatherModal(
                date: val['day'].toString(),
                weather: val['weather'].toString(),
                summary: val['summary'].toString(),
                tempF: val['temperature'].toString(),
                tempMin: val['temperature_min'].toString(),
                tempMax: val['temperature_max'].toString(),
                windSpeedMph: val['wind']['speed'].toString(),
                windAngle: val['wind']['angle'].toString(),
                windDir: val['wind']['dir'].toString(),
                humidity: val['humidity'].toString()
            ));
        foreCast.refresh();
      }
    }).onError((error, stackTrace) {
      setRxStatusCode(Status.ERROR);
      errorMessage.value = error.toString();
      if(kDebugMode){
        print(error.toString());
      }
    });
  }


}
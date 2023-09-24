

import 'package:weather_app/Data/Api%20Services/api_services.dart';
import 'package:weather_app/Res/App%20urls/app_urls.dart';

class CityWeatherRepository{

  final apiServices = ApiServices();

  Future<dynamic> getCityWeather(String lat, String lon) async{
    Map<String, String> headers = {
      'X-RapidAPI-Key': AppUrls.myApi,
      'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
    };
    final String url = '${AppUrls.getWeatherForSpecificPlace}$lat,$lon';
    var response = await apiServices.getApi(url, headers);
    return response;
  }

  Future<dynamic> getForeCastWeather(String lat, String lon) async{
    Map<String, String> headers = {
      'X-RapidAPI-Key': AppUrls.myApi,
      'X-RapidAPI-Host': 'ai-weather-by-meteosource.p.rapidapi.com'
    };
    final String url = '${AppUrls.getWeatherForCast21DaysSpecificPlace}lat=$lat&lon=$lon&language=en&units=auto';
    var response = await apiServices.getApi(url, headers);
    return response;
  }

}
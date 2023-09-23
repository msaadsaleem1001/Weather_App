
import 'package:weather_app/Data/Api%20Services/api_services.dart';
import 'package:weather_app/Res/App%20urls/app_urls.dart';

class CityRepository{

  final apiServices = ApiServices();

  Future<dynamic> getCities(String countryCode) async{
    Map<String, String> headers = {
      'X-RapidAPI-Key': AppUrls.myApi,
      'X-RapidAPI-Host': 'country-state-city-search-rest-api.p.rapidapi.com'
    };
    final String url = '${AppUrls.citySearchApi}$countryCode';
    var response = await apiServices.getApi(url, headers);
    return response;
  }

}
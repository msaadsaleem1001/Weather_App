
import 'package:weather_app/Data/Api%20Services/api_services.dart';
import 'package:weather_app/Res/App%20urls/app_urls.dart';

class CountryRepository{

  final apiServices = ApiServices();

  Future<dynamic> getCountries() async{
    Map<String, String> headers = {
      'X-RapidAPI-Key': AppUrls.myApi,
      'X-RapidAPI-Host': 'country-state-city-search-rest-api.p.rapidapi.com'
    };
    var response = await apiServices.getApi(AppUrls.countrySearchApi, headers);
    return response;
  }

}
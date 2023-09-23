

class AppUrls{

  static const String myApi = 'acdfbbe6ddmshc11110a22114808p1afcefjsn57685565ed48';

  // params: {q: '53.1,-0.13'},
  // headers: {
  // 'X-RapidAPI-Key': 'My Api',
  // 'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
  // }
  static const String getWeatherForSpecificPlace = 'https://weatherapi-com.p.rapidapi.com/forecast.json';




  // params: {
  // lat: '37.81021',
  // lon: '-122.42282',
  // language: 'en',
  // units: 'auto'
  // },
  // headers: {
  // 'X-RapidAPI-Key': 'My Api',
  // 'X-RapidAPI-Host': 'ai-weather-by-meteosource.p.rapidapi.com'
  // }
  static const String getWeatherForCast21DaysSpecificPlace = 'https://ai-weather-by-meteosource.p.rapidapi.com/daily';



  // In Use
  // headers: {
  // 'X-RapidAPI-Key': 'myApi',
  // 'X-RapidAPI-Host': 'country-state-city-search-rest-api.p.rapidapi.com'
  // }
  // site url: https://rapidapi.com/rapihub-rapihub-default/api/country-state-city-search-rest-api/
  static const String countrySearchApi = 'https://country-state-city-search-rest-api.p.rapidapi.com/allcountries';

  // In Use
  // Api for get the all cities of specific country with lat and long only passing the country code.
  // Map<String, String> headers = {
  // 'X-RapidAPI-Key': 'My Api',
  // 'X-RapidAPI-Host': 'country-state-city-search-rest-api.p.rapidapi.com'
  // };
  // Map<String, String> qPrams = {
  // countrycode: 'PK'
  // };
  static const String citySearchApi = 'https://country-state-city-search-rest-api.p.rapidapi.com/cities-by-countrycode?countrycode=';

}
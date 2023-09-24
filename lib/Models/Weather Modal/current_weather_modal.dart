

class CurrentWeatherModal {
  final String name;
  final String region;
  final String country;
  final String lastUpdated;
  final String tempC;
  final String maxTempC;
  final String tempF;
  final String maxTempF;
  final bool isDay;
  final String text;
  final String icon;
  final String windMph;
  final String windKph;
  final String windDegree;
  final String windDir;
  final String humidity;

  CurrentWeatherModal(
      {
        required this.name,
        required this.region,
        required this.country,
        required this.lastUpdated,
        required this.tempC,
        required this.maxTempC,
        required this.tempF,
        required this.maxTempF,
        required this.isDay,
        required this.text,
        required this.icon,
        required this.windMph,
        required this.windKph,
        required this.windDegree,
        required this.windDir,
        required this.humidity
      });
}
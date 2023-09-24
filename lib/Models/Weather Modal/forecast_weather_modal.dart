

class ForeCastWeatherModal {
  final String date;
  final String weather;
  final String summary;
  final String tempF;
  final String tempMin;
  final String tempMax;
  final String windSpeedMph;
  final String windDir;
  final String windAngle;
  final String humidity;

  ForeCastWeatherModal(
      {
        required this.date,
        required this.weather,
        required this.summary,
        required this.tempF,
        required this.tempMin,
        required this.tempMax,
        required this.windSpeedMph,
        required this.windAngle,
        required this.windDir,
        required this.humidity
      });
}
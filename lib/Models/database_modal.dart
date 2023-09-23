class DatabaseCityModal {
  final int? id;
  final String cityName;
  final String countryCode;
  final String lat;
  final String lon;
  final bool isDefault;
  final bool isSelected;

  DatabaseCityModal(
      {
        this.id,
        required this.cityName,
        required this.countryCode,
        required this.lat,
        required this.lon,
        required this.isDefault,
        required this.isSelected
      });

  factory DatabaseCityModal.fromJson(Map<String, dynamic> map) {
    return DatabaseCityModal(
      id: map['id'],
      cityName: map['cityName'],
      countryCode: map['countryCode'],
      lat: map['lat'],
      lon: map['lon'],
      isDefault: map['isDefault'] == 1,
      isSelected: map['isSelected'] == 1
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
      'countryCode': countryCode,
      'lat': lat,
      'lon': lon,
      'isDefault': isDefault == true ? 1 : 0,
      'isSelected': isSelected == true ? 1 : 0
    };
  }
}
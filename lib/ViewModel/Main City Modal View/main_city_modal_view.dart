
// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:get/get.dart';
import 'package:weather_app/DataBase/Database%20Repository/database_class.dart';
import 'package:weather_app/Models/city_modal.dart';
import 'package:weather_app/Models/database_modal.dart';
import 'package:weather_app/Res/Routes/routes_names.dart';
import 'package:weather_app/ViewModel/HomeModal/home_modal.dart';

class MainModal extends GetxController{

  final db = DatabaseRepository.instance;

  RxInt selectedCities = 0.obs;
  RxInt get geterSelectedCities => selectedCities;

  //List of Cities data
  RxList<CityModal> citiesList = [
    CityModal(
      cityName: 'London',
      countryCode: 'GB',
      lat: '51.509865',
      lon: '-0.118092',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Tokyo',
      countryCode: 'JP',
      lat: '35.652832',
      lon: '139.839478',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Delhi',
      countryCode: 'IN',
      lat: '28.644800',
      lon: '77.216721',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
        cityName: 'Beijing',
        countryCode: 'CN',
        lat: '39.916668',
        lon: '116.383331',
        isDefault: false,
        isSelected: false
    ),
    CityModal(
      cityName: 'Paris',
      countryCode: 'FR',
      lat: '48.864716',
      lon: '2.349014',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
        cityName: 'Rome',
        countryCode: 'IT',
        lat: '41.902782',
        lon: '12.496366',
        isDefault: false,
        isSelected: false
    ),
    CityModal(
      cityName: 'Lagos',
      countryCode: 'NG',
      lat: '6.465422',
      lon: '3.406448',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Bahawalpur',
      countryCode: 'PK',
      lat: '29.418068',
      lon: '71.670685',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Berlin',
      countryCode: 'DE',
      lat: '52.520008',
      lon: '13.404954',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Miami',
      countryCode: 'US',
      lat: '25.761681',
      lon: '-80.191788',
      isDefault: false,
      isSelected: false,
    ),
    CityModal(
      cityName: 'Amsterdam',
      countryCode: 'NL',
      lat: '52.377956',
      lon: '4.897070',
      isDefault: false,
      isSelected: false,
    ),
  ].obs;

  void insertUserSelectedListToDB() async{
    final homeModal = Get.put(HomeModal());
    homeModal.userList.clear();
    await db.deleteAll();
    for(var val in citiesList){
      if(val.isSelected){
        homeModal.userList.add(DatabaseCityModal(
            cityName: val.cityName,
            countryCode: val.countryCode,
            lat: val.lat,
            lon: val.lon,
            isDefault: val.isDefault,
            isSelected: val.isSelected
        ));
        await db.insert(databaseCityModal: DatabaseCityModal(
            cityName: val.cityName,
            countryCode: val.countryCode,
            lat: val.lat,
            lon: val.lon,
            isDefault: val.isDefault,
            isSelected: val.isSelected
        ));
      }
    }
    Get.toNamed(RouteNames.homeScreen);
  }

  //Get the selected cities
  void getSelectedCities(){
    selectedCities.value = 0;
    citiesList.forEach((element) {
      if(element.isSelected){
        selectedCities.value++;
      }
    });
  }

}
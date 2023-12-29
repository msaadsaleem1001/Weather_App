
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Models/city_modal.dart';
import 'package:weather_app/Repository/City%20Repository/city_rep.dart';
import 'package:weather_app/ViewModel/Main%20City%20Modal%20View/main_city_modal_view.dart';

class SelectionViewModel extends GetxController{


  final CityRepository cityRepository = CityRepository();
  final citiesSearchTextEditingController = TextEditingController().obs;
  final citiesSearchFocusNode = FocusNode().obs;
  final rxStatusCode = Status.LOADING.obs;
  RxString errorMessage = 'Error'.obs;
  RxString countryCode = "PK".obs;
  RxString countryName = "Pakistan".obs;
  RxList searchCityList = [].obs;
  RxList searchedCityList = [].obs;
  RxList selectedCitiesList = [].obs;

  void setRxStatusCode(Status val) => rxStatusCode.value = val;
  void setCountryCode(String val) => countryCode.value = val;
  void setCountryName(String val) => countryName.value = val;

  void citiesSearchListApi(){
    searchedCityList.clear();
    setRxStatusCode(Status.LOADING);
    cityRepository.getCities(countryCode.value).then((value) {
      setRxStatusCode(Status.COMPLETED);
      searchCityList.value = List.from(value).toList();
      getSearchedCityList();
    }).onError((error, stackTrace) {
      setRxStatusCode(Status.ERROR);
      errorMessage.value = error.toString();
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  void getSearchedCityList(){
    searchedCityList.clear();
    for(int i = 0; i < searchCityList.length; i++){
      if(citiesSearchTextEditingController.value.text.isNotEmpty){
        if(searchCityList[i]['name'].toString().toLowerCase().contains(citiesSearchTextEditingController.value.text.toLowerCase())){
          searchedCityList.add(CityModal(
              cityName: searchCityList[i]['name'].toString(),
              countryCode: searchCityList[i]['countryCode'].toString(),
              lat: searchCityList[i]['latitude'].toString(),
              lon: searchCityList[i]['longitude'].toString(),
              isDefault: false,
              isSelected: false));
        }
      }
      else{
        searchedCityList.add(CityModal(
            cityName: searchCityList[i]['name'].toString(),
            countryCode: searchCityList[i]['countryCode'].toString(),
            lat: searchCityList[i]['latitude'].toString(),
            lon: searchCityList[i]['longitude'].toString(),
            isDefault: false,
            isSelected: false));
      }

    }
  }

  void getSelectedCitiesList(){
    final mainController = Get.put(MainModal());
    for (var element in searchedCityList) {
      if(element.isSelected){
        selectedCitiesList.add(
            CityModal(
                cityName: element.cityName,
                countryCode: element.countryCode,
                lat: element.lat,
                lon: element.lon,
                isDefault: element.isDefault,
                isSelected: element.isSelected
            )
        );
      }
    }
    if(selectedCitiesList.isNotEmpty){
      for(var element in selectedCitiesList){
        mainController.citiesList.add(
            CityModal(
                cityName: element.cityName,
                countryCode: element.countryCode,
                lat: element.lat,
                lon: element.lon,
                isDefault: element.isDefault,
                isSelected: element.isSelected
            )
        );
      }
    }
    mainController.citiesList.refresh();
    mainController.getSelectedCities();
  }
}
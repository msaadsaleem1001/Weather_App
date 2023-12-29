
// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Models/CountriesModal.dart';
import 'package:weather_app/Repository/Country%20Repository/country_repository.dart';

class SearchViewModel extends GetxController{

  final CountryRepository countryRepository = CountryRepository();
  final rxStatusCode = Status.LOADING.obs;
  RxString errorMessage = 'Error'.obs;
  RxList searchCountryList = [].obs;
  RxList searchedCountryList = [].obs;

  void setRxStatusCode(Status value) => rxStatusCode.value = value;

  void countriesSearchListApi(){
    setRxStatusCode(Status.LOADING);
    searchedCountryList.clear();
    searchCountryList.clear();
    countryRepository.getCountries().then((value) {
      setRxStatusCode(Status.COMPLETED);
      searchCountryList.value = List.from(value).toList();
      searchCountryList.forEach((element) {
        searchedCountryList.add(
            CountriesModal(
                countryName: element['name'],
                countryCode: element['isoCode'],
                countryFlag: element['flag'],
            ));
      });
    }).onError((error, stackTrace) {
      setRxStatusCode(Status.ERROR);
      errorMessage.value = error.toString();
      if(kDebugMode){
        print(error.toString());
      }
    });
  }


}
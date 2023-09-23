

import 'package:get/get.dart';
import 'package:weather_app/Models/database_modal.dart';

class HomeModal extends GetxController{

  RxList<DatabaseCityModal> userList = [
    DatabaseCityModal(
        cityName: '',
        countryCode: '',
        lat: '',
        lon: '',
        isDefault: false,
        isSelected: false
    )].obs;


}

import 'dart:async';
import 'package:get/get.dart';
import 'package:weather_app/DataBase/Database%20Repository/database_class.dart';
import 'package:weather_app/Models/database_modal.dart';
import 'package:weather_app/Res/Routes/routes_names.dart';
import 'package:weather_app/ViewModel/HomeModal/home_modal.dart';

class SplashServices {

  final db = DatabaseRepository.instance;

  List<DatabaseCityModal> userList = [];

  void isDefaultSelected() async{
    // print(await db.deleteAll());
    userList = await db.getAllSelectedCities();
    Timer(const Duration(seconds: 3), (){
      if(userList.isEmpty){
        Get.toNamed(RouteNames.selectionScreen);
      }
      else{
        final homeModal = Get.put(HomeModal());
        homeModal.userList.clear();
        for(var val in userList){
          homeModal.userList.add(val);
        }
        Get.toNamed(RouteNames.homeScreen);
      }
    });
  }
}
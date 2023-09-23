
// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Res/Components/error_widget.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/ViewModel/Search%20Modal/search_modal.dart';
import 'package:weather_app/ViewModel/Selection%20Services/selection_model.dart';

class Utils {

  static void generateSnackBar(String title, String msg){
    Get.snackbar(title, msg,
        titleText: Text(title, style: AppTextStyles.headerTextStyle(color: AppColors.white),),
        messageText: Text(msg, style: AppTextStyles.normalStyle(color: AppColors.white),),
        colorText: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM
    );
  }

  void showBottomSheet(BuildContext context, Size screenSize, AnimationController animationController){
    SearchViewModel searchViewModel = Get.put(SearchViewModel());
    SelectionViewModel selectionViewModel = Get.put(SelectionViewModel());
    Get.bottomSheet(
      BottomSheet(
          animationController: animationController,
          onClosing: (){},
          builder: (context){
            return Container(
              width: screenSize.width,
              height: screenSize.height*.8,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Select Country',
                          style: AppTextStyles.headerTextStyle(
                              color: AppColors.primaryColor),
                        )),
                    ],
                  ),
                  Obx(() => Expanded(
                    child: searchViewModel.rxStatusCode == Status.LOADING
                        ? Center(child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ))
                        : searchViewModel.rxStatusCode == Status.COMPLETED
                        ? ListView.builder(
                        itemCount: searchViewModel.searchedCountryList.length,
                        itemBuilder: (context, index) {
                            return ListTile(
                              onTap: (){
                                selectionViewModel.setCountryCode(searchViewModel.searchedCountryList[index].countryCode);
                                selectionViewModel.setCountryName(searchViewModel.searchedCountryList[index].countryName);
                                selectionViewModel.citiesSearchListApi();
                                Get.back();
                              },
                              title: Text(
                                searchViewModel.searchedCountryList[index].countryName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.black
                                ),
                              ),
                              trailing: Text(searchViewModel.searchedCountryList[index].countryFlag,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.black
                                ),
                              ),
                            );
                        })
                        : Obx(() => ExceptionWidget(
                            msg: searchViewModel.errorMessage.value,
                              retry: () {
                              searchViewModel.countriesSearchListApi();
                      },
                    ))
                  ),),
                ],
              ),
            );
          }),
    );
  }


}
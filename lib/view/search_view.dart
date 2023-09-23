// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Data/Response/status.dart';
import 'package:weather_app/Res/Components/error_widget.dart';
import 'package:weather_app/Res/Components/text_form_field.dart';
import 'package:weather_app/Res/assets/app_assets.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/Utils/utils/app_utilities.dart';
import 'package:weather_app/ViewModel/Main%20City%20Modal%20View/main_city_modal_view.dart';
import 'package:weather_app/ViewModel/Search%20Modal/search_modal.dart';
import 'package:weather_app/ViewModel/Selection%20Services/selection_model.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key});

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> with TickerProviderStateMixin {
  final controllerSelectionModal = Get.put(SelectionViewModel());
  final controllerSearchModal = Get.put(SearchViewModel());
  final controllerMainModal = Get.put(MainModal());
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerSelectionModal.citiesSearchListApi();
    controllerSearchModal.countriesSearchListApi();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<SearchViewModel>();
    Get.delete<SelectionViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: (){
          controllerSelectionModal.getSelectedCitiesList();
          Get.back();
        },
        child: Icon(Icons.add, size: 25, color: AppColors.white,),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        foregroundColor: AppColors.white,
        centerTitle: true,
        title: Obx(() {
          return Text(
            controllerSelectionModal.countryName.value,
            style: AppTextStyles.headerTextStyle(color: AppColors.white),
          );
        }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                enableFeedback: false,
                onTap: () {
                  Utils utils = Utils();
                  utils.showBottomSheet(
                    context,
                    screenSize,
                    animationController,
                  );
                },
                child: Obx(() => Text(
                      controllerSelectionModal.countryCode.value,
                      style:
                          AppTextStyles.headerTextStyle(color: AppColors.white),
                    ))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormFieldReUseAble(
                focusNode: controllerSelectionModal.citiesSearchFocusNode.value,
                textEditingController: controllerSelectionModal
                    .citiesSearchTextEditingController.value,
                hintText: 'Search by city name',
                obsecureText: false,
                labelText: 'City Name',
                prefixIcon: const Icon(Icons.search_rounded),
                onFieldSubmitted: (val) {
                  controllerSelectionModal.getSearchedCityList();
                },
                onTapOutSide: (val) {
                  controllerSelectionModal.citiesSearchFocusNode.value
                      .unfocus();
                },
                onKeyUp: (val) {
                  controllerSelectionModal.getSearchedCityList();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Text(
                      'Total cities: ${controllerSelectionModal.searchedCityList.length.toString()}',
                    ))
              ],
            ),
            Obx(
              () => Expanded(
                child: controllerSelectionModal.rxStatusCode == Status.LOADING
                    ? const Center(child: CircularProgressIndicator())
                    : controllerSelectionModal.rxStatusCode == Status.COMPLETED
                        ? ListView.builder(
                            itemCount: controllerSelectionModal
                                .searchedCityList.length,
                            itemBuilder: (context, index) {
                              return Obx(() => Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 20, right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: screenSize.height * .06,
                                    width: screenSize.width,
                                    decoration: BoxDecoration(
                                        border: controllerSelectionModal
                                                    .searchedCityList[index]
                                                    .isSelected ==
                                                true
                                            ? Border.all(
                                                color: AppColors.secondaryColor
                                                    .withOpacity(.6),
                                                width: 2,
                                              )
                                            : Border.all(color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryColor
                                                .withOpacity(.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          )
                                        ]),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              controllerSelectionModal.searchedCityList[index].isSelected = !controllerSelectionModal.searchedCityList[index].isSelected;
                                              controllerSelectionModal.searchedCityList.refresh();
                                            },
                                            child: Image.asset(
                                              controllerSelectionModal
                                                          .searchedCityList[
                                                              index]
                                                          .isSelected ==
                                                      true
                                                  ? AppAssets.checked
                                                  : AppAssets.unChecked,
                                              width: 30,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          controllerSelectionModal
                                              .searchedCityList[index].cityName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: controllerSelectionModal
                                                        .searchedCityList[index]
                                                        .isSelected ==
                                                    true
                                                ? AppColors.primaryColor
                                                : AppColors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            })
                        : controllerSelectionModal.rxStatusCode == Status.ERROR
                            ? Obx(() => ExceptionWidget(
                                  msg: controllerSearchModal.errorMessage.value,
                                  retry: () {
                                    controllerSelectionModal
                                        .citiesSearchListApi();
                                  },
                                ))
                            : const Center(child: Text('Results not matched')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

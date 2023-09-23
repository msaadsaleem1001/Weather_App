import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Res/assets/app_assets.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/Utils/utils/app_utilities.dart';
import 'package:weather_app/ViewModel/Main%20City%20Modal%20View/main_city_modal_view.dart';
import 'package:weather_app/view/home.dart';
import 'package:weather_app/view/search_view.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final controller = Get.put(MainModal());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<MainModal>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        title: Obx(
          () => Text(
            '${controller.geterSelectedCities.value} Selected',
            style: AppTextStyles.montserratStyle(
                color: AppColors.white, fontSize: 18),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                enableFeedback: false,
                onPressed: () {
                  Get.to(const CitySearch());
                },
                icon: Icon(Icons.search_rounded,
                    size: 25, color: AppColors.white)),
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.citiesList.length,
          itemBuilder: (context, index) {
            return Obx(() => Container(
              margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * .08,
              width: size.width,
              decoration: BoxDecoration(
                  border: controller.citiesList[index].isSelected == true
                      ? Border.all(
                    color: AppColors.secondaryColor.withOpacity(.6),
                    width: 2,
                  )
                      : Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.citiesList[index].isSelected =
                        !controller.citiesList[index].isSelected;
                        controller.citiesList.refresh();
                        controller.getSelectedCities();
                      },
                      child: Image.asset(
                        controller.citiesList[index].isSelected == true
                            ? AppAssets.checked
                            : AppAssets.unChecked,
                        width: 30,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(controller.citiesList[index].cityName,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                        controller.citiesList[index].isSelected == true
                            ? AppColors.primaryColor
                            : Colors.black54,
                      )),
                ],
              ),
            ));
          })),
      floatingActionButton: Obx(()=>FloatingActionButton(
        backgroundColor: controller.geterSelectedCities.value == 0
            ?AppColors.readableContent
            :AppColors.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          if(controller.geterSelectedCities.value == 0){
            Utils.generateSnackBar('Note', 'Select at least one city');
          }
          else{
            controller.insertUserSelectedListToDB();
          }
        },
      ),)
    );
  }
}

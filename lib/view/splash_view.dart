

import 'package:flutter/material.dart';
import 'package:weather_app/Res/assets/app_assets.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';
import 'package:weather_app/ViewModel/Splash%20Services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices services = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.isDefaultSelected();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: AppColors.primaryColor.withOpacity(.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.getStarted),
            SizedBox(height: size.height*.05,),
            Center(
              child: Text('Get started', style: AppTextStyles.montserratStyle(color: AppColors.primaryColor, fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}

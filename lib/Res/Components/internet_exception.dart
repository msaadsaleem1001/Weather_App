import 'package:flutter/material.dart';
import 'package:weather_app/Res/colors/app_colors.dart';

class InternetExceptionWidget extends StatefulWidget {
  const InternetExceptionWidget({super.key});

  @override
  State<InternetExceptionWidget> createState() => _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.cloud_off_rounded, size: 50, color: AppColors.primaryColor,)),
          const SizedBox(height: 30,),
          const Center(
            child: Text("No Internet"),
          )
      ],),
    );
  }
}


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';


class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget ;
  const CheckInternetConnectionWidget({
    super.key,
    required this.snapshot,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: height * .03,
              width: width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.error,
              ),
              child: Center(child: Text('No Internet Connection',
                style: AppTextStyles.normalStyle(color: AppColors.white, fontSize: 14),)),
            );
          default:
            return  widget;
        }
      default:
        return const Text('');
    }
  }
}
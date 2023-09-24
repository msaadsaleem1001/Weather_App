import 'package:flutter/material.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';


class ExceptionWidget extends StatefulWidget {
  final String msg;
  final VoidCallback retry;
  const ExceptionWidget({
    super.key,
    required this.msg,
    required this.retry
  });

  @override
  State<ExceptionWidget> createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error,)),
        const SizedBox(height: 20),
        Center(
          child: Text(
              widget.msg,
              style: AppTextStyles.readableStyle(16),
              textAlign: TextAlign.center
          ),),
        const SizedBox(height: 20),
        Center(
          child: InkWell(
            enableFeedback: false,
            onTap: widget.retry,
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.readableContent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Retry', style: AppTextStyles.montserratStyle(
                        color: AppColors.white,
                        fontSize: 16),),
                    const SizedBox(width: 5,),
                    Icon(Icons.change_circle_rounded, color: AppColors.white, size: 30,)
                  ],
                )
              ),
            ),
          )
        )
      ],);
  }
}

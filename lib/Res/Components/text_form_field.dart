import 'package:flutter/material.dart';
import 'package:weather_app/Res/colors/app_colors.dart';
import 'package:weather_app/Res/text%20styles/app_text_styles.dart';

class TextFormFieldReUseAble extends StatelessWidget {
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final bool obsecureText;
  final int? maxlen;
  final Function(dynamic)? validator;
  final Function(dynamic)? onFieldSubmitted;
  final Function(dynamic)? onKeyUp;
  final Function(dynamic)? onTapOutSide;
  const TextFormFieldReUseAble(
      {super.key,
        required this.focusNode,
        required this.textEditingController,
        required this.hintText,
        required this.obsecureText,
        required this.labelText,
        this.maxlen,
        this.postfixIcon,
        this.prefixIcon,
        this.validator,
        this.keyboardType,
        this.onFieldSubmitted,
        this.onKeyUp,
        this.onTapOutSide});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: AppTextStyles.montserratStyle(
          color: AppColors.readableContent, fontSize: 12),
      maxLength: maxlen,
      focusNode: focusNode,
      cursorColor: AppColors.primaryColor,
      controller: textEditingController,
      obscureText: obsecureText,
      obscuringCharacter: '*',
      onChanged: onKeyUp,
      decoration: InputDecoration(
          suffixIconColor: AppColors.primaryColor,
          prefixIconColor: AppColors.primaryColor,
          labelText: labelText,
          hoverColor: AppColors.secondaryColor,
          labelStyle: AppTextStyles.montserratStyle(
              color: AppColors.primaryColor, fontSize: 12),
          hintText: hintText,
          hintStyle: AppTextStyles.readableStyle(14),
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: postfixIcon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.skillsContainer,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
              ),
      validator: (value) => validator!(value),
      onFieldSubmitted: (value) => onFieldSubmitted!(value),
      onTapOutside: onTapOutSide,
    );
  }
}

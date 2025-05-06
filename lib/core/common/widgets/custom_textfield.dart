import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:jsulima/core/utils/constants/colors.dart' show AppColors;

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        style: getTextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text; 
  final VoidCallback onPressed;
  final Color? color;
  final double? vertical; 
  final Color? textColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.vertical = 16, 
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            vertical: vertical!, 
          ),
          child: Center(
            child: Text(
              text,
              style: getTextStyle(
                color: textColor!,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
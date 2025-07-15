import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';

class SelectPreferredGameContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String image;
  final Color color;
  final Color textColor;
  final double? imagewidth;
  final double? imageheight;
  const SelectPreferredGameContainer({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
    required this.color,
    required this.textColor,
    this.imagewidth = 24,
    this.imageheight = 24,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.35,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: getTextStyle(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5),
              Image.asset(image, height: 24, width: 24),
            ],
          ),
        ),
      ),
    );
  }
}

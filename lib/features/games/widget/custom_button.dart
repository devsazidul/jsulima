import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/screen/game_details_screen.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GameDetailsScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.5),
        width: 330,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFCA0101),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "View Prediction",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

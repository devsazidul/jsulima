import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 105, vertical: 14.5),
      width: 330,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFCA0101), // Color #CA0101
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "View Prediction",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

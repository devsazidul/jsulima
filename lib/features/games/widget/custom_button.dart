import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/screen/game_details_screen.dart';

class CustomButton extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Image;
  final String team2Image;
  final String matchTime;
  final double team1Percentage;
  final double team2Percentage;
  const CustomButton({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.team1Image,
    required this.team2Image,
    required this.matchTime,
    required this.team1Percentage,
    required this.team2Percentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GameDetailsScreen(team1Name: team1Name, team2Name: team2Name, team1Image: team1Image, team2Image: team2Image, matchTime: matchTime, team1Percentage: team1Percentage, team2Percentage: team2Percentage,));
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

import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/details/game_details_container.dart';

class GameDetailsScreen extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Image;
  final String team2Image;
  final String matchTime;
  final double team1Percentage;
  final double team2Percentage;
  const GameDetailsScreen({super.key, required this.team1Name, required this.team2Name, required this.team1Image, required this.team2Image, required this.matchTime, required this.team1Percentage, required this.team2Percentage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: GameDetailsContainer(team1Name: team1Name, team2Name: team2Name, team1Image: team1Image, team2Image: team2Image, matchTime: matchTime, team1Percentage: team1Percentage, team2Percentage: team2Percentage,),
      ),
    );
  }
}

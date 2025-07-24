import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/game_details_controller.dart';
import 'package:jsulima/features/game_details/widget/details/ai_confidence_row.dart';
import 'package:jsulima/features/game_details/widget/details/game_details_top_section.dart';

import 'package:jsulima/features/game_details/widget/details/tab_content.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class GameDetailsContainer extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Image;
  final String team2Image;
  final String matchTime;
  final double team1Percentage;
  final double team2Percentage;
  final String venue;

  const GameDetailsContainer({
    super.key,
    required this.team1Percentage,
    required this.team2Percentage,
    required this.team1Name,
    required this.team2Name,
    required this.team1Image,
    required this.team2Image,
    required this.matchTime, required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final GameDetailsController gameDetailsController = Get.put(
      GameDetailsController(),
    );
    final GameController gameController = Get.put(GameController());

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GameDetailsTopSection(
            gameController: gameController,
            team1Name: team1Name,
            team2Name: team2Name,
            team1Image: team1Image,
            team2Image: team2Image,
            matchTime: matchTime,
            team1Percentage: team1Percentage,
            team2Percentage: team2Percentage,
          ),
          AIConfidenceRow(venue: venue,),
          SizedBox(height: 20),
          TabNavigation(team1Name: team1Name, team2Name: team2Name),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

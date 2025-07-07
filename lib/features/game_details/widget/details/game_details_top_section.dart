import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jsulima/features/game_details/widget/game_details_top_container.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class GameDetailsTopSection extends StatelessWidget {
  
  final GameController gameController;
  final String team1Name;
  final String team2Name;
  final String team1Image;
  final String team2Image;
  final String matchTime;
  final double team1Percentage;
  final double team2Percentage;
  const GameDetailsTopSection({super.key, required this.gameController, required this.team1Name, required this.team2Name, required this.team1Image, required this.team2Image, required this.matchTime, required this.team1Percentage, required this.team2Percentage});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          gameController.selectedButton.value == 0
              ? GameDetailsTopContainer(
                team1Image: team1Image,
                team2Image: team2Image,
                team1Name: team1Name,
                team2Name: team2Name,
                matchTime: matchTime,
                team1Per: team1Percentage,
                team2Per: team2Percentage,
              )
              : GameDetailsTopContainer(
                team1Image: team1Image,
                team2Image: team2Image,
                team1Name: team1Name,
                team2Name: team2Name,
                matchTime: matchTime,
                team1Per: team1Percentage,
                team2Per: team2Percentage,
              ),
    );
  }
}

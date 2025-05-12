import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/game_details_controller.dart';
import 'package:jsulima/features/game_details/widget/details/ai_confidence_row.dart';
import 'package:jsulima/features/game_details/widget/details/game_details_top_section.dart';

import 'package:jsulima/features/game_details/widget/details/tab_navigation.dart';
import 'package:jsulima/features/game_details/widget/player_tab_container.dart';
import 'package:jsulima/features/game_details/widget/prediction_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/state_tab_container.dart';
import 'package:jsulima/features/game_details/widget/tuneup_screen.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class GameDetailsContainer extends StatelessWidget {
  final double team1Percentage;
  final double team2Percentage;

  const GameDetailsContainer({
    super.key,
    required this.team1Percentage,
    required this.team2Percentage,
  });

  @override
  Widget build(BuildContext context) {
    final GameDetailsController gameDetailsController = Get.put(
      GameDetailsController(),
    );
    final GameController gameController = Get.put(GameController());

    return SingleChildScrollView(
      child: Column(
        children: [
          GameDetailsTopSection(gameController: gameController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AIConfidenceRow(),
                SizedBox(height: 50),
                TabNavigation(gameDetailsController: gameDetailsController),
                SizedBox(height: 24),
                Obx(() {
                  if (gameDetailsController.selectedIndex.value == 0) {
                    return PredictionContainer();
                  } else if (gameDetailsController.selectedIndex.value == 1) {
                    return PlayerTabContainer();
                  } else if (gameDetailsController.selectedIndex.value == 2) {
                    return TuneupScreen();
                  } else {
                    return StateTabContainer(team1Win: 3, team2Win: 2, draw: 0);
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

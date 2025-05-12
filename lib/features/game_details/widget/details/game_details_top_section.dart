import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/game_details_top_container.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class GameDetailsTopSection extends StatelessWidget {
  final GameController gameController;

  const GameDetailsTopSection({super.key, required this.gameController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          gameController.selectedButton.value == 0
              ? GameDetailsTopContainer(
                team1Image: ImagePath.atlantaFalcon,
                team2Image: ImagePath.carolinaPanther,
                team1Name: 'Atlanta\nFalcon',
                team2Name: 'Carolina\nPanther',
                team1Per: 40,
                team2Per: 60,
              )
              : GameDetailsTopContainer(
                team1Image: ImagePath.newYorkYankees,
                team2Image: ImagePath.bostonRedSox,
                team1Name: 'New York\nYankees',
                team2Name: 'Boston Red\nSox',
                team1Per: 55,
                team2Per: 45,
              ),
    );
  }
}

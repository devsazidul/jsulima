import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/widget/field_widget.dart';
import 'package:jsulima/features/game_details/widget/mlb_players_widget.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class TuneupScreen extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  TuneupScreen({super.key, required this.team1Name, required this.team2Name});
  final GameController gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () =>
                gameController.selectedButton.value == 0
                    ? FieldWidget(team1Name: team1Name, team2Name: team2Name)
                    : MlbPlayersWidget(
                      team1Name: team1Name,
                      team2Name: team2Name,
                    ),
          ),
        ],
      ),
    );
  }
}

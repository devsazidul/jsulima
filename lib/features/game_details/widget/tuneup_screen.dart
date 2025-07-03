import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/widget/field_widget.dart';
import 'package:jsulima/features/game_details/widget/lineup_button.dart';
import 'package:jsulima/features/game_details/widget/mlb_players_widget.dart';
import 'package:jsulima/features/game_details/widget/player_list.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';

class TuneupScreen extends StatelessWidget {
  TuneupScreen({super.key});
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
                    ? FieldWidget()
                    : MlbPlayersWidget(),
          ),

          SizedBox(height: 20),
          LineupButton(playerName: "Atlanta Braves"),
          SizedBox(height: 20),
          PlayerList(teamName: 'Atlanta Braves'),
          SizedBox(height: 10),
          LineupButton(playerName: "Boston Red Sox"),
          SizedBox(height: 20),
          PlayerList(teamName: 'Boston Red Sox'),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/widget/field_widget.dart';
import 'package:jsulima/features/game_details/widget/lineup_button.dart';
import 'package:jsulima/features/game_details/widget/mlb_players_widget.dart';
import 'package:jsulima/features/game_details/widget/player_list.dart';

import 'package:jsulima/features/home/controller/home_controller.dart';

class TuneupScreen extends StatelessWidget {
  TuneupScreen({super.key}) {}
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () =>
                controller.selectedLeague.value == "NFL"
                    ? FieldWidget()
                    : MlbPlayersWidget(),
          ),

          SizedBox(height: 20),
          LineupButton(playerName: "Atlanta Falcon (3-4-3)"),
          SizedBox(height: 20),
          PlayerList(),
          SizedBox(height: 10),
          LineupButton(playerName: "Carolina Panther (3-4-3)"),
          SizedBox(height: 20),
          PlayerList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

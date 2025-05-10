import 'package:flutter/material.dart';
import 'package:jsulima/features/game_details/widget/field_widget.dart';
import 'package:jsulima/features/game_details/widget/lineup_button.dart';
import 'package:jsulima/features/game_details/widget/player_list.dart';

class TuneupScreen extends StatelessWidget {
  const TuneupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldWidget(),
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

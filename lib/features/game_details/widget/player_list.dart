import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../games/controller/game_controller.dart';

class PlayerList extends StatelessWidget {
  final String teamName;
  PlayerList({super.key, required this.teamName});

  final GameController gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    final lineupPlayerModel = gameController.lineupResponse;

    final players = lineupPlayerModel?.lineup ?? [];
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: players.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final player = players[index];
        return Card(
          color: Colors.grey[800],
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/icons/userprofile.png',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, color: Colors.grey);
                },
              ),
            ),
            title: Text(
              player.playerName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              player.playerPosition,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '#${player.playerNumber}',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

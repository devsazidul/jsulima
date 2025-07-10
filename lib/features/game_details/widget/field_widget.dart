import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/field_controller.dart';
import 'package:jsulima/features/game_details/model/field_lineup_model.dart';
import 'package:jsulima/features/game_details/widget/lineup_button.dart';
import 'package:shimmer/shimmer.dart';

class FieldWidget extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  const FieldWidget({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    FieldController controller;
    try {
      controller = Get.find<FieldController>();
    } catch (e) {
      controller = Get.put(FieldController());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.imageBase64.value.isEmpty && !controller.isLoading.value) {
        controller.fetchLineupAndImage(team1Name, team2Name);
      }
    });

    return Obx(() {
      return Column(
        children: [
          if (controller.isLoading.value) buildShimmerImage(),
          if (!controller.isLoading.value &&
              controller.imageBase64.value.isNotEmpty)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(base64Decode(controller.imageBase64.value)),
              ),
            ),
          if (!controller.isLoading.value &&
              controller.imageBase64.value.isNotEmpty)
            const SizedBox(height: 10),

          if (controller.isLoading.value) buildShimmerPlayerList(),
          if (!controller.isLoading.value &&
              controller.homePlayers.isNotEmpty) ...[
            LineupButton(playerName: team1Name),
            buildSimplePlayerList(controller.homePlayers),
            const SizedBox(height: 10),
          ],

          if (!controller.isLoading.value &&
              controller.awayPlayers.isNotEmpty) ...[
            LineupButton(playerName: team2Name),
            buildSimplePlayerList(controller.awayPlayers),
          ],
        ],
      );
    });
  }

  Widget buildShimmerImage() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 300,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget buildShimmerPlayerList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder:
              (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 60,
              ),
        ),
      ),
    );
  }

  Widget buildSimplePlayerList(List<FieldPlayer> players) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players.length,
        itemBuilder: (context, index) => buildSimplePlayerTile(players[index]),
      ),
    );
  }

  Widget buildSimplePlayerTile(FieldPlayer player) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "#" + player.playerNumber.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.playerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${player.playerPosition} • ${player.unitGroup}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(player.starterProbability * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  color:
                      player.starterProbability > 0.5
                          ? Colors.green
                          : Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                player.starterPrediction == 1 ? 'Starter' : 'Bench',
                style: TextStyle(
                  color:
                      player.starterPrediction == 1
                          ? Colors.green
                          : Colors.grey[400],
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/mlb_controller.dart';
import 'package:jsulima/features/game_details/model/mlb_lineup_model.dart';
import 'package:jsulima/features/game_details/widget/lineup_button.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class MlbPlayersWidget extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  const MlbPlayersWidget({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    final MlbPlayerController controller = Get.put(MlbPlayerController());
    final RxString selectedTeam = team1Name.obs;

    // Fetch lineup for the default team if not already loaded
    if (controller.players.isEmpty && !controller.isLoading.value) {
      controller.fetchLineupAndImage(selectedTeam.value);
    }

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Team buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TeamButton(
                label: team1Name,
                isSelected: selectedTeam.value == team1Name,
                onTap: () {
                  if (selectedTeam.value != team1Name) {
                    selectedTeam.value = team1Name;
                    controller.fetchLineupAndImage(team1Name);
                  }
                },
              ),
              const SizedBox(width: 16),
              TeamButton(
                label: team2Name,
                isSelected: selectedTeam.value == team2Name,
                onTap: () {
                  if (selectedTeam.value != team2Name) {
                    selectedTeam.value = team2Name;
                    controller.fetchLineupAndImage(team2Name);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Image under the buttons with shimmer loader
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
            const SizedBox(height: 20),
          // Player list shimmer or actual list
          if (controller.isLoading.value) buildShimmerPlayerList(),
          if (!controller.isLoading.value) ...[
            LineupButton(playerName: selectedTeam.value),

            buildSimplePlayerList(controller.players),
            const SizedBox(height: 10),
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

  Widget buildSimplePlayerList(List<MlbPlayer> players) {
    return Container(
      decoration: BoxDecoration(),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players.length,
        itemBuilder: (context, index) => buildSimplePlayerTile(players[index]),
      ),
    );
  }

  Widget buildSimplePlayerTile(MlbPlayer player) {
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
                "#${player.playerNumber}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
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
                  '${player.playerPosition} • ${player.positionGroup}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(player.starterProbability).toStringAsFixed(1)}%',
                style: TextStyle(
                  color:
                      player.starterProbability > 50
                          ? Colors.green
                          : Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                player.status,
                style: TextStyle(
                  color:
                      player.status == 'active'
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

class TeamButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const TeamButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        foregroundColor:
            isSelected ? Colors.white : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

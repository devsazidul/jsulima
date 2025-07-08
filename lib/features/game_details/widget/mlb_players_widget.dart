import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/mlb_controller.dart';
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
    print('MlbPlayersWidget is building');
    final MlbPlayerController controller = Get.put(MlbPlayerController());
    final RxString selectedTeam = team1Name.obs;

    // Fetch lineup and image for the default team if not already loaded
    if (controller.imageBase64.value.isEmpty && !controller.isLoading.value) {
      controller.fetchLineupAndImage(selectedTeam.value);
    }

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          if (controller.isLoading.value)
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            )
          else if (controller.imageBase64.value.isEmpty)
            Center(child: Image.asset('assets/icons/mlb.png'))
          else
            Center(
              child: Image.memory(base64Decode(controller.imageBase64.value)),
            ),
        ],
      );
    });
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

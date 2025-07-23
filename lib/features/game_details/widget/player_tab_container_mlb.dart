import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/controller/player_tab_controller.dart';
import 'package:jsulima/features/game_details/widget/player_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/shimmer_player_card.dart';
import 'package:jsulima/features/game_details/widget/team_button.dart';

class PlayerTabContainerMlb extends StatelessWidget {
  final String team1Name;
  final String team2Name;

  const PlayerTabContainerMlb({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerTabController());
    controller.fetchTopPerformers(team1Name, team2Name);

    return Obx(() {
      if (controller.isLoading.value) {
        return Column(
          children: [
            ShimmerPlayerCard(),
            SizedBox(height: 15),
            ShimmerPlayerCard(),
          ],
        );
      } else if (controller.error.value.isNotEmpty) {
        return Center(
          child: Text(
            controller.error.value,
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else if (controller.apiData.value.isEmpty) {
        return const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      final filteredHomePlayers = controller.getFilteredHomePlayers();
      final filteredAwayPlayers = controller.getFilteredAwayPlayers();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Performer Prediction',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(height: 20),
          TeamButton(teamName: team1Name, imagePath: ImagePath.newYorkYankees),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => controller.setHomeTeamFilter('batter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.homeTeamFilter.value == 'batter'
                          ? const Color(0xFFCA0101)
                          : const Color(0xFFABABAB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Top Batter',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => controller.setHomeTeamFilter('pitcher'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.homeTeamFilter.value == 'pitcher'
                          ? const Color(0xFFCA0101)
                          : const Color(0xFFABABAB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Top Pitcher',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          filteredHomePlayers.isEmpty
              ? const Center(
                child: Text(
                  'No players available for home team',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredHomePlayers.length,
                itemBuilder: (context, index) {
                  final team1 = filteredHomePlayers[index];
                  return PlayerTabWidget(
                    key: ValueKey('home_${team1['playerName']}_$index'),
                    aiConfidence: team1['aiConfidence'],
                    playerImagePath: team1['playerImagePath'],
                    playerName: team1['playerName'],
                    playerPosition: team1['playerPosition'],
                    stats: List<Map<String, String>>.from(team1['stats']),
                  );
                },
              ),
          const SizedBox(height: 48),
          TeamButton(teamName: team2Name, imagePath: ImagePath.bostonRedSox),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => controller.setAwayTeamFilter('batter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.awayTeamFilter.value == 'batter'
                          ? const Color(0xFFCA0101)
                          : const Color(0xFFABABAB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Top Batter',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => controller.setAwayTeamFilter('pitcher'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.awayTeamFilter.value == 'pitcher'
                          ? const Color(0xFFCA0101)
                          : const Color(0xFFABABAB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Top Pitcher',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          filteredAwayPlayers.isEmpty
              ? const Center(
                child: Text(
                  'No players available for away team',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredAwayPlayers.length,
                itemBuilder: (context, index) {
                  final team2 = filteredAwayPlayers[index];
                  return PlayerTabWidget(
                    key: ValueKey('away_${team2['playerName']}_$index'),
                    aiConfidence: team2['aiConfidence'],
                    playerImagePath: team2['playerImagePath'],
                    playerName: team2['playerName'],
                    playerPosition: team2['playerPosition'],
                    stats: List<Map<String, String>>.from(team2['stats']),
                  );
                },
              ),
        ],
      );
    });
  }
}

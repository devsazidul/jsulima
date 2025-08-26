import 'package:flutter/material.dart';
import 'package:jsulima/core/models/player_model.dart';
import 'package:jsulima/core/services/player_service.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/player_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/shimmer_player_card.dart';
import 'package:jsulima/features/game_details/widget/team_button.dart';

class PlayerTabContainer extends StatelessWidget {
  final String team1Name;
  final String team2Name;

  const PlayerTabContainer({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: PlayerService().fetchTopPerformers(team1Name, team2Name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              ShimmerPlayerCard(),
              SizedBox(height: 15),
              ShimmerPlayerCard(),
            ],
          );
        } else if (snapshot.hasError) {
          debugPrint('FutureBuilder Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No data received from API');
          return const Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        if (!data.containsKey('top_performers')) {
          debugPrint(
            'Invalid data format: top_performers key not found in $data',
          );
          return const Center(
            child: Text('Invalid data format: top_performers not found'),
          );
        }

        final topPerformers = data['top_performers'];
        if (topPerformers['hometeam'] == null ||
            topPerformers['awayteam'] == null) {
          debugPrint(
            'Missing hometeam or awayteam in top_performers: $topPerformers',
          );
          return const Center(
            child: Text('Invalid data: Missing team information'),
          );
        }

        // Updated to pass defaultImage to PlayerModel.mapPlayersToTeam
        final teams1 = PlayerModel.mapPlayersToTeam(
          topPerformers['hometeam']['players'] ?? [],
          defaultImage: ImagePath.atlantaFalcon, // Default image for home team
        );
        final teams2 = PlayerModel.mapPlayersToTeam(
          topPerformers['awayteam']['players'] ?? [],
          defaultImage:
              ImagePath.carolinaPanther, // Default image for away team
        );

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
            TeamButton(teamName: team1Name, imagePath: ImagePath.atlantaFalcon),
            const SizedBox(height: 20),
            teams1.isEmpty
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
                  itemCount: teams1.length,
                  itemBuilder: (context, index) {
                    final team1 = teams1[index];
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
            TeamButton(
              teamName: team2Name,
              imagePath: ImagePath.carolinaPanther,
            ),
            const SizedBox(height: 20),
            teams2.isEmpty
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
                  itemCount: teams2.length,
                  itemBuilder: (context, index) {
                    final team2 = teams2[index];
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
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jsulima/core/models/player_model.dart';
import 'package:jsulima/core/services/player_service.dart';
import 'package:jsulima/features/game_details/widget/prediction_player_container.dart';
import 'package:jsulima/features/game_details/widget/shimmer_player_card.dart';

class PredictionTabWidgetNfl extends StatelessWidget {
  final String team1Name;
  final String team2Name;

  const PredictionTabWidgetNfl({
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
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No data received from API');
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final data = snapshot.data!;
        if (!data.containsKey('top_performers')) {
          debugPrint(
            'Invalid data format: top_performers key not found in $data',
          );
          return const Center(
            child: Text(
              'Invalid data format: top_performers not found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final topPerformers = data['top_performers'];
        if (topPerformers['hometeam'] == null ||
            topPerformers['awayteam'] == null) {
          debugPrint(
            'Missing hometeam or awayteam in top_performers: $topPerformers',
          );
          return const Center(
            child: Text(
              'Invalid data: Missing team information',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final teams1 = PlayerModel.mapPlayersToTeam(
          topPerformers['hometeam']['players'] ?? [],
        );
        final teams2 = PlayerModel.mapPlayersToTeam(
          topPerformers['awayteam']['players'] ?? [],
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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final team1 = teams1[index];
                    return PlayerContainer(
                      key: ValueKey('home_${team1['playerName']}_$index'),
                      teamName: team1Name,
                      playerImagePath: team1['playerImagePath'],
                      playerName: team1['playerName'],
                      playerPosition: team1['playerPosition'],
                      aiConfidence: team1['aiConfidence'],
                      stats: List<Map<String, String>>.from(team1['stats']),
                    );
                  },
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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final team2 = teams2[index];
                    return PlayerContainer(
                      key: ValueKey('away_${team2['playerName']}_$index'),
                      teamName: team2Name,
                      playerImagePath: team2['playerImagePath'],
                      playerName: team2['playerName'],
                      playerPosition: team2['playerPosition'],
                      aiConfidence: team2['aiConfidence'],
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

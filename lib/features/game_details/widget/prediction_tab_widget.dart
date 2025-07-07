import 'package:flutter/material.dart';
import 'package:jsulima/features/game_details/widget/prediction_player_container.dart';

class PredictionContainer extends StatelessWidget {
  PredictionContainer({super.key});

  final List<Map<String, dynamic>> players = [
    {
      'teamName': 'Atlanta Falcon',
      'playerImagePath': 'assets/images/matt-ryan-1.png',
      'playerName': 'Matt Ryan',
      'playerPosition': 'Quarterback',
      'aiConfidence': '85%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
        {'value': '1', 'label': 'Interceptions'},
      ],
    },
    {
      'teamName': 'Carolina Panther',
      'playerImagePath': 'assets/images/player1.png',
      'playerName': 'Sam Darnold',
      'playerPosition': 'Quarterback',
      'aiConfidence': '70%',
      'stats': [
        {'value': '290', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
        {'value': '1', 'label': 'Interceptions'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Performer Prediction',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            height: 1.3,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return PlayerContainer(
              teamName: player['teamName'],
              playerImagePath: player['playerImagePath'],
              playerName: player['playerName'],
              playerPosition: player['playerPosition'],
              aiConfidence: player['aiConfidence'],
              stats: List<Map<String, String>>.from(player['stats']),
            );
          },
        ),
      ],
    );
  }
}

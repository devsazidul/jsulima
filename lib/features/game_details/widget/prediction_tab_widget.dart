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
      'playerImagePath': 'assets/images/image.png',
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Game Prediction',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Predicted Score',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF28A745),
            ),
          ),
          SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                color: Color(0xFFEBEBEB),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Atlanta Falcon '),
                TextSpan(
                  text: ' - ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                TextSpan(
                  text: ' 27',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    height: 1.3,
                    color: Color(0xFFC60C30),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                color: Color(0xFFEBEBEB),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Carolina Panther '),
                TextSpan(
                  text: ' - ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                TextSpan(
                  text: ' 21',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    height: 1.3,
                    color: Color(0xFF216AFD),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Key Insights',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF28A745),
            ),
          ),
          SizedBox(height: 12),
          Text(
            "The Atlanta Falcons are favored in this matchup due to their strong offensive line and quarterback play by Matt Ryan, but Carolina Panthers' defense will be a challenge. The Falcons' ability to move the ball downfield, especially with Cordarrelle Patterson's versatility, is expected to give them an edge.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5,
              color: Color(0xFFEBEBEB),
            ),
          ),
          SizedBox(height: 40),
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
      ),
    );
  }
}

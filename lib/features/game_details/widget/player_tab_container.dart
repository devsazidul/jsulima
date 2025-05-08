import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/player_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/team_button.dart';

class PlayerTabContainer extends StatelessWidget {
  PlayerTabContainer({super.key});

  final List<Map<String, dynamic>> teams1 = [
    {
      'playerImagePath': 'assets/images/matt-ryan-1.png',
      'playerName': 'Matt Ryan',
      'playerPosition': 'Quarterback',
      'aiConfidence': '90%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
        {'value': '1', 'label': 'Interceptions'},
      ],
    },
    {
      'playerImagePath': 'assets/images/player2.png',
      'playerName': 'Cordarrelle Patterson',
      'playerPosition': 'Running Back',
      'aiConfidence': '90%',
      'stats': [
        {'value': '310', 'label': 'Rushing Yards'},
        {'value': '1', 'label': 'Touchdowns'},
        {'value': '55', 'label': 'Receiving Yards'},
      ],
    },
    {
      'playerImagePath': 'assets/images/player3.png',
      'playerName': 'Calvin Ridley',
      'playerPosition': 'Wide Receiver',
      'aiConfidence': '70%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
        {'value': '1', 'label': 'Interceptions'},
      ],
    },
    {
      'playerImagePath': 'assets/images/player4.png',
      'playerName': 'Deion Jones',
      'playerPosition': 'Linebackers',
      'aiConfidence': '90%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
      ],
    },
    {
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
  final List<Map<String, dynamic>> teams2 = [
    {
      'playerImagePath': 'assets/images/player3.png',
      'playerName': 'Calvin Ridley',
      'playerPosition': 'Wide Receiver',
      'aiConfidence': '70%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
        {'value': '1', 'label': 'Interceptions'},
      ],
    },
    {
      'playerImagePath': 'assets/images/player4.png',
      'playerName': 'Deion Jones',
      'playerPosition': 'Linebackers',
      'aiConfidence': '90%',
      'stats': [
        {'value': '310', 'label': 'Passing Yards'},
        {'value': '2', 'label': 'Touchdowns'},
      ],
    },
    {
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
    return SingleChildScrollView(
      child: Column(
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
          TeamButton(
            teamName: 'Atlanta Falcon',
            imagePath: ImagePath.atlantaFalcon,
          ),
          SizedBox(height: 20),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: teams1.length,
            itemBuilder: (context, index) {
              final team1 = teams1[index];
              return PlayerTabWidget(
                aiConfidence: team1['aiConfidence'],
                playerImagePath: team1['playerImagePath'],
                playerName: team1['playerName'],
                playerPosition: team1['playerPosition'],
                stats: List<Map<String, String>>.from(team1['stats']),
              );
            },
          ),
          SizedBox(height: 48),
          TeamButton(
            teamName: 'Carolina Panther',
            imagePath: ImagePath.carolinaPanther,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: teams2.length,
            itemBuilder: (context, index) {
              final team2 = teams2[index];
              return PlayerTabWidget(
                aiConfidence: team2['aiConfidence'],
                playerImagePath: team2['playerImagePath'],
                playerName: team2['playerName'],
                playerPosition: team2['playerPosition'],
                stats: List<Map<String, String>>.from(team2['stats']),
              );
            },
          ),
        ],
      ),
    );
  }
}

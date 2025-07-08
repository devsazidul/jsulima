import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/teams_widget.dart';

class StateTabContainer extends StatelessWidget {
  final int team1Win, team2Win, draw;
  final String team1Name, team2Name;

  StateTabContainer({
    super.key,
    required this.team1Win,
    required this.team2Win,
    required this.draw,
    required this.team1Name,
    required this.team2Name,
  });

  final List<Map<String, dynamic>> teams = [
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '38',
      'team2Score': '44',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 6, 2025',
    },
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '21',
      'team2Score': '30',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 7, 2025',
    },
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '25',
      'team2Score': '18',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 8, 2025',
    },
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '19',
      'team2Score': '27',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 9, 2025',
    },
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '24',
      'team2Score': '21',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 10, 2025',
    },
    {
      'team1Name': 'Atlanta Falcon',
      'team1ImagePath': ImagePath.atlantaFalcon,
      'team1Score': '24',
      'team2Score': '34',
      'team2Name': 'Carolina Panther',
      'team2ImagePath': ImagePath.carolinaPanther,
      'date': 'Jan 12, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalWins = team1Win + team2Win;
    final team1Percentage = totalWins > 0 ? (team1Win / totalWins) * 100 : 0.0;
    final team2Percentage = totalWins > 0 ? (team2Win / totalWins) * 100 : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Head-to-Head Record',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            height: 1.3,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Last 5 Matches',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.5,
            color: Color(0xFFABABAB),
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team1Name,
                  style: TextStyle(
                    color: Color(0xFFEBEBEB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$team1Win Wins',
                  style: TextStyle(
                    color: Color(0xFFABABAB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Draws',
                  style: TextStyle(
                    color: Color(0xFFEBEBEB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$draw',
                  style: TextStyle(
                    color: Color(0xFFABABAB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  team2Name,
                  style: TextStyle(
                    color: Color(0xFFEBEBEB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$team2Win Wins',
                  style: TextStyle(
                    color: Color(0xFFABABAB),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: team1Percentage.toInt(),
              child: Container(
                height: 5,
                decoration: BoxDecoration(color: Color(0xFFC60C30)),
              ),
            ),
            SizedBox(width: 3),
            Expanded(
              flex: team2Percentage.toInt(),
              child: Container(
                height: 5,
                decoration: BoxDecoration(color: Color(0xFF216AFD)),
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams[index];
            return TeamsWidget(
              team1Name: team['team1Name'],
              team1ImagePath: team['team1ImagePath'],
              team1Score: team['team1Score'],
              team2Score: team['team2Score'],
              team2Name: team['team2Name'],
              team2ImagePath: team['team2ImagePath'],
              date: team['date'],
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/widget/teams_widget.dart';
import 'package:jsulima/features/game_details/model/head_to_head_model.dart';

class StateTabContainer extends StatelessWidget {
  final int team1Win, team2Win, draw;
  final String team1Name, team2Name;
  final List<HeadToHeadMatch> matches;

  const StateTabContainer({
    super.key,
    required this.team1Win,
    required this.team2Win,
    required this.draw,
    required this.team1Name,
    required this.team2Name,
    required this.matches,
  });

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
          'Last ${matches.length} Matches',
          style: TextStyle(
            fontWeight: FontWeight.w800,
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
                SizedBox(height: 10),
                Text(
                  ' $team1Win Wins',
                  style: TextStyle(
                    color: Color(0xFFABABAB),
                    fontWeight: FontWeight.w800,
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
                SizedBox(height: 10),
                Text(
                  ' $draw',
                  style: TextStyle(
                    color: Color(0xFFABABAB),
                    fontWeight: FontWeight.w800,
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
                SizedBox(height: 10),
                Text(
                  ' $team2Win Wins',
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
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final match = matches[index];
            // You may want to map team names to images if available, else use a placeholder
            return TeamsWidget(
              team1Name: match.homeTeam,
              team1ImagePath: ImagePath.atlantaFalcon, // TODO: Map by name
              team1Score: match.homeScore.toString(),
              team2Score: match.awayScore.toString(),
              team2Name: match.awayTeam,
              team2ImagePath: ImagePath.carolinaPanther, // TODO: Map by name
              date: match.date,
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jsulima/features/game_details/widget/stats_widget.dart';

class PlayerTabWidget extends StatelessWidget {
  final String aiConfidence;
  final String playerImagePath;
  final String playerName;
  final String playerPosition;
  final List<Map<String, String>> stats;
  const PlayerTabWidget({
    super.key,
    required this.stats,
    required this.aiConfidence,
    required this.playerImagePath,
    required this.playerName,
    required this.playerPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                playerImagePath,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    playerPosition,
                    style: TextStyle(
                      color: Color(0xFFABABAB),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Predicted Stats',
            style: TextStyle(
              color: Color(0xFFF2F2F2),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.3,
            ),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  stats.map((stat) {
                    return StatsContainer(
                      statValue: stat['value']!,
                      label: stat['label']!,
                    );
                  }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 11),
                child: Text(
                  'AI Confidence',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.3,
                    color: Color(0xFFFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 11),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFCA0101),
                  borderRadius: BorderRadius.circular(72),
                ),
                child: Text(
                  aiConfidence,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.3,
                    color: Color(0xFFFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

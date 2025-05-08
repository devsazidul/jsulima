import 'package:flutter/material.dart';
import 'package:jsulima/features/game_details/widget/stats_container.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 264,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Atlanta Falcon',
            style: TextStyle(
              color: Color(0xFF28A745),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'assets/images/matt-ryan-1.png',
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matt Ryan',
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Quarterback',
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
          Row(
            children: [
              StatsContainer(statValue: '310', label: 'Passing Yards'),
              Spacer(),
              StatsContainer(statValue: '2', label: 'Touchdowns'),
              Spacer(),
              StatsContainer(statValue: '1', label: 'Interceptions'),
            ],
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
                  '85%',
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

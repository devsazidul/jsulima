import 'package:flutter/material.dart';
import 'package:jsulima/features/games/widget/custom_button.dart';

class PredictionContainer extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  final String team1Image;
  final String team2Image;
  final String matchTime;
  final String predictionText;
  final double team1Percentage;
  final double team2Percentage;

  const PredictionContainer({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.team1Image,
    required this.team2Image,
    required this.matchTime,
    required this.predictionText,
    required this.team1Percentage,
    required this.team2Percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF393939),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(team1Image, height: 26, width: 48),
                  SizedBox(height: 2),
                  SizedBox(
                    width: 83,
                    child: Text(
                      team1Name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFEBEBEB), fontSize: 16),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VS',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    matchTime,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Image.asset(team2Image, height: 26, width: 48),
                  SizedBox(height: 2),
                  SizedBox(
                    width: 83,
                    child: Text(
                      team2Name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFEBEBEB), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team1Name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${team1Percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFFC60C30),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    team2Name,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${team2Percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFF216AFD),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFF393939),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: (team1Percentage).toInt(),
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(color: Color(0xFFC60C30)),
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    flex: (team2Percentage).toInt(),
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(color: Color(0xFF216AFD)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Color(0xFFABABAB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Prediction: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Colors.red,
                  ),
                ),
                TextSpan(text: predictionText),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),
          CustomButton(),
        ],
      ),
    );
  }
}

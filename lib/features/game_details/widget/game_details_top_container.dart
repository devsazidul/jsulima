import 'package:flutter/material.dart';

class GameDetailsTopContainer extends StatelessWidget {
  final String team1Image;
  final String team1Name;
  final String team2Image;
  final String team2Name;
  final double team1Per;
  final double team2Per;
  const GameDetailsTopContainer({super.key, required this.team1Image, required this.team2Image, required this.team1Name, required this.team2Name, required this.team1Per, required this.team2Per});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 335,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  height: 330,
                  width: 402,
                  "assets/images/playground.png",
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 115,
                    left: 28,
                    right: 28,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            team1Image,
                            height: 76,
                            width: 80,
                          ),
                          Spacer(),
                          Text(
                            'VS',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              height: 1.2,
                              color: Color(0xFFFFFFFF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Image.asset(
                            team2Image,
                            height: 76,
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            team1Name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.2,
                              color: Color(0xFFFFFFFF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Text(
                            "14 Feb\n3:00 PM",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.4,
                              color: Color(0xFFFFFFFF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          SizedBox(height: 8),
                          Text(
                            team2Name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.2,
                              color: Color(0xFFFFFFFF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Atlanta Falcon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${team1Per.toStringAsFixed(0)}%",
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
                                'Carolina Panther',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${team2Per.toStringAsFixed(0)}%",
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
                      Row(
                        children: [
                          Expanded(
                            flex: (team1Per).toInt(),
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: Color(0xFFC60C30),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            flex: (team2Per).toInt(),
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: Color(0xFF216AFD),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
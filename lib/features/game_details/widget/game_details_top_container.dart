import 'package:flutter/material.dart';

class GameDetailsTopContainer extends StatelessWidget {
  final String team1Image;
  final String team1Name;
  final String team2Image;
  final String team2Name;
  final String matchTime;
  final double team1Per;
  final double team2Per;
  const GameDetailsTopContainer({
    super.key,
    required this.team1Image,
    required this.team2Image,
    required this.team1Name,
    required this.team2Name,
    required this.team1Per,
    required this.team2Per,
    required this.matchTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            height: 350,
            width: MediaQuery.of(context).size.width,
            "assets/images/playground.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 115, left: 28, right: 28, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(team1Image, height: 76, width: 80),
                        SizedBox(height: 2),
                        SizedBox(
                          width: 83,
                          child: Text(
                            team1Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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
                        Image.asset(team2Image, height: 76, width: 88),
                        SizedBox(height: 2),
                        SizedBox(
                          width: 83,
                          child: Text(
                            team2Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                        decoration: BoxDecoration(color: Color(0xFFC60C30)),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      flex: (team2Per).toInt(),
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(color: Color(0xFF216AFD)),
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

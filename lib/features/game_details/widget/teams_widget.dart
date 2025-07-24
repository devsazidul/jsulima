import 'package:flutter/material.dart';

class TeamsWidget extends StatelessWidget {
  final String team1Name;
  final String team1ImagePath;
  final String team1Score;
  final String team2Score;
  final String team2Name;
  final String team2ImagePath;
  final String date;

  const TeamsWidget({
    super.key,
    required this.team1Name,
    required this.team1ImagePath,
    required this.team1Score,
    required this.team2Score,
    required this.team2Name,
    required this.team2ImagePath,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 11),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF393939),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(
                team1ImagePath,
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                formatVenue(team1Name),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.3,
                  color: Color(0xFFF2F2F2),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: team1Score,
                      style: TextStyle(
                        color: Color(0xFFCA0101),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: '-',
                      style: TextStyle(
                        color: Color(0xFFCA0101),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: team2Score,
                      style: TextStyle(
                        color: Color(0xFFCA0101),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.5,
                  color: Color.fromARGB(255, 92, 90, 90),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Image.asset(
                team2ImagePath,
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                formatVenue(team2Name),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.3,
                  color: Color(0xFFF2F2F2),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatVenue(String venue) {
    List<String> words = venue.split(' ');
    List<String> groupedWords = [];
    for (int i = 0; i < words.length; i += 2) {
      groupedWords.add(words.skip(i).take(2).join(' '));
    }
    return groupedWords.join('\n');
  }
}

import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String team1Name;
  final String team1LogoPath;
  final String team2Name;
  final String team2LogoPath;
  final String matchDateTime;

  const MatchCard({
    super.key,
    required this.team1Name,
    required this.team1LogoPath,
    required this.team2Name,
    required this.team2LogoPath,
    required this.matchDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/container_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset(team1LogoPath, height: 60),
              const SizedBox(height: 8),
              Text(
                formatVenue(team1Name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'VS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                matchDateTime,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(team2LogoPath, height: 60),
              const SizedBox(height: 8),
              Text(
                formatVenue(team2Name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
    for (int i = 0; i < words.length; i += 1) {
      groupedWords.add(words.skip(i).take(1).join(' '));
    }
    return groupedWords.join('\n');
  }
}

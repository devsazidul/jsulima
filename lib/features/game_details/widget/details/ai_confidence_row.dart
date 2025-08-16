import 'package:flutter/material.dart';

class AIConfidenceRow extends StatelessWidget {
  final String venue;
  final String aiConfidence;
  const AIConfidenceRow({super.key, required this.venue, required this.aiConfidence});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'AI Confidence',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.3,
              color: Color(0xFFFFFFFF),
            ),
            textAlign: TextAlign.center,
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
          Spacer(),
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5,
                color: Color(0xFFEBEBEB),
              ),
              children: <TextSpan>[
                TextSpan(text: 'Venue: '),
                TextSpan(
                  text: formatVenue(venue),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xFFCA0101),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatVenue(String venue) {
    List<String> words = venue.split(' ');
    List<String> groupedWords = [];
    for (int i = 0; i < words.length; i += 3) {
      groupedWords.add(words.skip(i).take(3).join(' '));
    }
    return groupedWords.join('\n');
  }
}

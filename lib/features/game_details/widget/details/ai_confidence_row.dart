import 'package:flutter/material.dart';

class AIConfidenceRow extends StatelessWidget {
  const AIConfidenceRow({super.key});

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
          Spacer(),
          RichText(
            textAlign: TextAlign.center,
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
                  text: ' Allegiant Stadium',
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
}

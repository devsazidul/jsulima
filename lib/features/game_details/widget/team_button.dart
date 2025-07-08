import 'package:flutter/material.dart';

class TeamButton extends StatelessWidget {
  final String teamName;
  final String imagePath;
  const TeamButton({
    super.key,
    required this.teamName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 15, width: 15),
          SizedBox(width: 10),
          Text(
            teamName,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFFCA0101),
            ),
          ),
        ],
      ),
    );
  }
}

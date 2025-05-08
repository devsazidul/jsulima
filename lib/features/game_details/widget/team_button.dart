import 'package:flutter/material.dart';

class TeamButton extends StatelessWidget {
  final String teamName ;
  final String imagePath;
  const TeamButton({super.key, required this.teamName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: 140,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(imagePath, height: 15, width: 15),
            Spacer(),
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
      ),
    );
  }
}

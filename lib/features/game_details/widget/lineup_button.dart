import 'package:flutter/material.dart';

class LineupButton extends StatelessWidget {
  final String playerName;
  const LineupButton({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 5),
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 12),
            Image(
              image: AssetImage('assets/icons/falcon.png'),
              height: 20,
              width: 20,
            ),
            SizedBox(width: 8),
            Text(
              '$playerName',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

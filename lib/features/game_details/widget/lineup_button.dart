import 'package:flutter/material.dart';

class LineupButton extends StatelessWidget {
  final String playerName;
  const LineupButton({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5),
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/icons/falcon.png'),
            height: 20,
            width: 20,
          ),
          SizedBox(width: 8),
          Text(
            'Atlanta Falcon (3-4-3)',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

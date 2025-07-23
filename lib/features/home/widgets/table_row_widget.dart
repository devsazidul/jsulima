import 'package:flutter/material.dart';

class TableRowWidget extends StatelessWidget {
  final String team;
  final String win;
  final String loss;
  final String avgPts;
  final String prediction;

  const TableRowWidget({
    super.key,
    required this.team,
    required this.avgPts,
    required this.prediction, required this.win, required this.loss,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              team,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Text(
              '$win : $loss',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Text(
              avgPts,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Text(
              prediction,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StatsContainer extends StatelessWidget {
  final String statValue;
  final String label;

  const StatsContainer({
    super.key,
    required this.statValue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
      height: 74,
      width: 113,
      decoration: BoxDecoration(
        color: Color(0xFFFFF2E6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            statValue,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.2,
              color: Color(0xFFCA0101),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color(0xFFABABAB),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StatBoxWidget extends StatelessWidget {
  final String value;
  final String label;

  const StatBoxWidget({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFFF6F0E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF5A3E2B), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

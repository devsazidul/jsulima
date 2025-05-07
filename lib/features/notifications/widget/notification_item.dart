import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  const NotificationItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF393939),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: Color(0xFFCA0101),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,

              color: Color(0xFFF2F2F2),
            ),
          ),
          SizedBox(height: 8),
          Text(
            subTitle,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFFABABAB),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 18,
            width: 67,
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF898989),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

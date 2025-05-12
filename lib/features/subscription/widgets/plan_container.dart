import 'package:flutter/material.dart';

class PlanContainer extends StatelessWidget {
  final String planName;
  final int price;
  final String planTime;
  const PlanContainer({
    super.key,
    required this.planName,
    required this.price,
    required this.planTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 24),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          height: 61,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF393939),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Plan',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFFABABAB),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Text(
                    planName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.3,
                      color: Color(0xFFF2F2F2),
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$$price',
                      style: TextStyle(
                        color: Color(0xFFCA0101),

                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: '/$planTime',
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Other Plans',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.2,
            color: Color(0xFFF2F2F2),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

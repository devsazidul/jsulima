import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';

class PlayerTabWidget extends StatelessWidget {
  const PlayerTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Performer Prediction',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.3,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(height: 20),
          Container(
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
                  Image.asset(ImagePath.atlantaFalcon, height: 15, width: 15),
                  Spacer(),
                  Text(
                    'Atlanta Falcon',
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
          ),
        ],
      ),
    );
  }
}

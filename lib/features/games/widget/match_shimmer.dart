import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MatchShimmer extends StatelessWidget {
  const MatchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(height: 26, width: 48, color: Colors.grey[300]),
                    const SizedBox(height: 2),
                    Container(width: 83, height: 16, color: Colors.grey[300]),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 32, color: Colors.grey[300]),
                    const SizedBox(height: 8),
                    Container(width: 60, height: 14, color: Colors.grey[300]),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Container(height: 26, width: 48, color: Colors.grey[300]),
                    const SizedBox(height: 2),
                    Container(width: 83, height: 16, color: Colors.grey[300]),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 60, height: 12, color: Colors.grey[300]),
                    const SizedBox(height: 4),
                    Container(width: 40, height: 14, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(width: 60, height: 12, color: Colors.grey[300]),
                    const SizedBox(height: 4),
                    Container(width: 40, height: 14, color: Colors.grey[300]),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 50,
                      child: Container(height: 5, color: Colors.grey[300]),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      flex: 50,
                      child: Container(height: 5, color: Colors.grey[300]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(width: 150, height: 14, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 48,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

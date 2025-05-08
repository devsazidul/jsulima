

import 'package:flutter/material.dart';

class NotchedCornerClipper extends CustomClipper<Path> {
  final double radius; // For the inward notch radius (now at bottom corners)
  final double bottomRadius; // For the outward rounded corners (now at top corners)

  NotchedCornerClipper({required this.radius, required this.bottomRadius});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double width = size.width;
    final double height = size.height;

    // Start at the bottom-left notch
    path.moveTo(0, height - radius);
    // Bottom-left notch (inward)
    path.arcToPoint(
      Offset(radius, height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    // Bottom edge
    path.lineTo(width - radius, height);
    // Bottom-right notch (inward)
    path.arcToPoint(
      Offset(width, height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    // Right edge
    path.lineTo(width, bottomRadius);
    // Top-right rounded corner (outward)
    path.arcToPoint(
      Offset(width - bottomRadius, 0),
      radius: Radius.circular(bottomRadius),
      clockwise: false,
    );
    // Top edge
    path.lineTo(bottomRadius, 0);
    // Top-left rounded corner (outward)
    path.arcToPoint(
      Offset(0, bottomRadius),
      radius: Radius.circular(bottomRadius),
      clockwise: false,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(NotchedCornerClipper oldClipper) {
    // Optimized to reclip only if parameters change
    return radius != oldClipper.radius || bottomRadius != oldClipper.bottomRadius;
  }
}
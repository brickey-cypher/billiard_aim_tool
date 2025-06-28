// lib/logic/billiard_ball.dart

import 'package:flutter/material.dart';

class BilliardBall {
  Offset position;
  final double radius;
  final Color color;
  final bool isCue;

  BilliardBall({
    required this.position,
    this.radius = 12.0,
    this.color = Colors.redAccent,
    this.isCue = false, // ✅ This line is essential
  });
}

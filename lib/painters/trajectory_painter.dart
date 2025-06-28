import 'package:flutter/foundation.dart'; // for listEquals
import 'package:flutter/material.dart';

class TrajectoryPainter extends CustomPainter {
  final List<Offset> points;
  final double ballRadius;

  TrajectoryPainter({required this.points, this.ballRadius = 10.0});

  @override
  void paint(Canvas canvas, Size size) {
    final trajectoryPaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final cueBallPaint = Paint()..color = Colors.red;
    final targetBallPaint = Paint()..color = Colors.blueAccent;

    // Draw trajectory lines
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], trajectoryPaint);
    }

    // Draw cue ball at first point
    if (points.isNotEmpty) {
      canvas.drawCircle(points.first, ballRadius, cueBallPaint);
    }

    // Draw target ball at last point
    if (points.length > 1) {
      canvas.drawCircle(points.last, ballRadius, targetBallPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TrajectoryPainter oldDelegate) {
    return !listEquals(points, oldDelegate.points) ||
        ballRadius != oldDelegate.ballRadius;
  }
}

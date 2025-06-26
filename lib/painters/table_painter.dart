import 'package:flutter/material.dart';

class TablePainter extends CustomPainter {
  final Rect tableRect;

  TablePainter(this.tableRect);

  @override
  void paint(Canvas canvas, Size size) {
    final boundaryPaint = Paint()
      ..color = Colors.brown.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawRect(tableRect, boundaryPaint);

    const pocketRadius = 18.0;
    final pocketPaint = Paint()..color = Colors.black;

    final pockets = [
      tableRect.topLeft,
      tableRect.topRight,
      tableRect.bottomLeft,
      tableRect.bottomRight,
      Offset(tableRect.left, tableRect.center.dy),
      Offset(tableRect.right, tableRect.center.dy),
    ];

    for (var pocket in pockets) {
      canvas.drawCircle(pocket, pocketRadius, pocketPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TablePainter oldDelegate) {
    return oldDelegate.tableRect != tableRect;
  }
}

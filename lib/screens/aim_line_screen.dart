
import 'package:flutter/material.dart';
import '../logic/bank_shot_logic.dart';
import '../logic/billiard_ball.dart';
import '../painters/trajectory_painter.dart';
import '../painters/table_painter.dart';

class AimLineScreen extends StatefulWidget {
  const AimLineScreen({super.key});

  @override
  State<AimLineScreen> createState() => _AimLineScreenState();
}

class _AimLineScreenState extends State<AimLineScreen> {
  final Size tableSize = const Size(300, 500);

  List<BilliardBall> balls = [];

  Rect get tableRect => Rect.fromLTWH(0, 0, tableSize.width, tableSize.height);

  @override
  void initState() {
    super.initState();
    balls = [
      BilliardBall(
        position: const Offset(150, 400),
        radius: 14.0,
        color: Colors.white,
        isCue: true,
      ),
      BilliardBall(
        position: const Offset(150, 200),
        color: Colors.redAccent,
      ),
    ];
  }

  void updateBallPosition(int index, Offset newPosition) {
    setState(() {
      balls[index].position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cue = balls.firstWhere((b) => b.isCue);
    final target = balls.firstWhere((b) => !b.isCue);

    final trajectoryPoints = calculateMultiCushionPath(
      cueBall: cue.position,
      targetBall: target.position,
      table: tableRect,
      maxBounces: 3,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Aim Line Screen')),
      body: Center(
        child: Container(
          width: tableSize.width,
          height: tableSize.height,
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(
                painter: TablePainter(tableRect),
                child: Container(),
              ),
              CustomPaint(
                painter: TrajectoryPainter(points: trajectoryPoints),
                child: Container(),
              ),
              for (int i = 0; i < balls.length; i++)
                Positioned(
                  left: balls[i].position.dx - balls[i].radius,
                  top: balls[i].position.dy - balls[i].radius,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final newOffset = balls[i].position + details.delta;
                      final clamped = _clampToBoundary(newOffset, balls[i].radius);
                      updateBallPosition(i, clamped);
                    },
                    child: Container(
                      width: balls[i].radius * 2,
                      height: balls[i].radius * 2,
                      decoration: BoxDecoration(
                        color: balls[i].color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(64),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Offset _clampToBoundary(Offset point, double radius) {
    final minX = tableRect.left + radius;
    final maxX = tableRect.right - radius;
    final minY = tableRect.top + radius;
    final maxY = tableRect.bottom - radius;
    return Offset(point.dx.clamp(minX, maxX), point.dy.clamp(minY, maxY));
  }
}

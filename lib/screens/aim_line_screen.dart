import 'package:flutter/material.dart';
import '../logic/bank_shot_logic.dart';
import '../painters/trajectory_painter.dart';
import '../painters/table_painter.dart';
import '../widgets/cue_ball.dart';
import '../widgets/target_ball.dart';

class AimLineScreen extends StatefulWidget {
  const AimLineScreen({super.key});

  @override
  State<AimLineScreen> createState() => _AimLineScreenState();
}

class _AimLineScreenState extends State<AimLineScreen> {
  Offset cueBallPosition = const Offset(150, 400);
  Offset targetBallPosition = const Offset(150, 200);
  final Size tableSize = const Size(300, 500);

  Rect get tableRect => Rect.fromLTWH(0, 0, tableSize.width, tableSize.height);

  void updateCueBall(Offset newPosition) {
    setState(() {
      cueBallPosition = newPosition;
    });
  }

  void updateTargetBall(Offset newPosition) {
    setState(() {
      targetBallPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trajectoryPoints = calculateMultiCushionPath(
      cueBall: cueBallPosition,
      targetBall: targetBallPosition,
      table: tableRect,
      maxBounces: 3,
    );

    debugPrint('🧠 cueBall: $cueBallPosition | 🎯 targetBall: $targetBallPosition');
    debugPrint('📐 trajectoryPoints: $trajectoryPoints');

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
              CueBall(
                position: cueBallPosition,
                boundary: tableRect,
                onPositionChanged: updateCueBall,
              ),
              TargetBall(
                position: targetBallPosition,
                boundary: tableRect,
                onPositionChanged: updateTargetBall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CueBall extends StatefulWidget {
  final Offset position;
  final ValueChanged<Offset> onPositionChanged;
  final Rect boundary;
  final double radius;

  const CueBall({
    super.key,
    required this.position,
    required this.onPositionChanged,
    required this.boundary,
    this.radius = 14.0,
  });

  @override
  State<CueBall> createState() => _CueBallState();
}

class _CueBallState extends State<CueBall> {
  late Offset offset;

  @override
  void initState() {
    super.initState();
    offset = widget.position;
  }

  Offset _clampToBoundary(Offset point) {
    final minX = widget.boundary.left + widget.radius;
    final maxX = widget.boundary.right - widget.radius;
    final minY = widget.boundary.top + widget.radius;
    final maxY = widget.boundary.bottom - widget.radius;
    return Offset(point.dx.clamp(minX, maxX), point.dy.clamp(minY, maxY));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx - widget.radius,
      top: offset.dy - widget.radius,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            offset = _clampToBoundary(offset + details.delta);
          });
          widget.onPositionChanged(offset);
        },
        child: Container(
          width: widget.radius * 2,
          height: widget.radius * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.25 * 255).round()),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

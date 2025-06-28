import 'dart:ui';
import 'dart:math';

extension OffsetHelpers on Offset {
  double get length => sqrt(dx * dx + dy * dy);

  Offset normalized() {
    final len = length;
    return len == 0 ? const Offset(0, 0) : this / len;
  }

  Offset reflectVertical() => Offset(-dx, dy);
  Offset reflectHorizontal() => Offset(dx, -dy);
}

Offset? rayTableIntersection(Offset start, Offset direction, Rect table) {
  List<double> tValues = [];

  if (direction.dx != 0) {
    double tLeft = (table.left - start.dx) / direction.dx;
    if (tLeft > 0) tValues.add(tLeft);

    double tRight = (table.right - start.dx) / direction.dx;
    if (tRight > 0) tValues.add(tRight);
  }

  if (direction.dy != 0) {
    double tTop = (table.top - start.dy) / direction.dy;
    if (tTop > 0) tValues.add(tTop);

    double tBottom = (table.bottom - start.dy) / direction.dy;
    if (tBottom > 0) tValues.add(tBottom);
  }

  if (tValues.isEmpty) return null;

  double tMin = tValues.reduce(min);
  Offset intersection = start + direction * tMin;

  return Offset(
    intersection.dx.clamp(table.left, table.right),
    intersection.dy.clamp(table.top, table.bottom),
  );
}

List<Offset> calculateMultiCushionPath({
  required Offset cueBall,
  required Offset targetBall,
  required Rect table,
  int maxBounces = 3,
}) {
  final direction = (targetBall - cueBall).normalized();
  List<Offset> path = [cueBall];
  Offset current = cueBall;
  Offset dir = direction;

  for (int i = 0; i < maxBounces; i++) {
    final next = rayTableIntersection(current, dir, table);
    if (next == null) break;

    path.add(next);

    if ((next.dx - table.left).abs() < 1e-6 ||
        (next.dx - table.right).abs() < 1e-6) {
      dir = dir.reflectVertical();
    }
    if ((next.dy - table.top).abs() < 1e-6 ||
        (next.dy - table.bottom).abs() < 1e-6) {
      dir = dir.reflectHorizontal();
    }

    current = next;
  }

  return path;
}

List<Offset> calculateBankShotPath({
  required Offset cueBall,
  required Offset targetBall,
  required Rect table,
}) {
  double leftDist = (targetBall.dx - table.left).abs();
  double rightDist = (table.right - targetBall.dx).abs();
  double topDist = (targetBall.dy - table.top).abs();
  double bottomDist = (table.bottom - targetBall.dy).abs();

  double minDist = leftDist;
  String edge = 'left';

  if (rightDist < minDist) {
    minDist = rightDist;
    edge = 'right';
  }
  if (topDist < minDist) {
    minDist = topDist;
    edge = 'top';
  }
  if (bottomDist < minDist) {
    minDist = bottomDist;
    edge = 'bottom';
  }

  Offset bouncePoint;
  Offset reflectedTarget;

  switch (edge) {
    case 'left':
      bouncePoint = Offset(table.left, targetBall.dy);
      reflectedTarget =
          Offset(table.left - (targetBall.dx - table.left), targetBall.dy);
      break;
    case 'right':
      bouncePoint = Offset(table.right, targetBall.dy);
      reflectedTarget =
          Offset(table.right - (targetBall.dx - table.right), targetBall.dy);
      break;
    case 'top':
      bouncePoint = Offset(targetBall.dx, table.top);
      reflectedTarget =
          Offset(targetBall.dx, table.top - (targetBall.dy - table.top));
      break;
    case 'bottom':
      bouncePoint = Offset(targetBall.dx, table.bottom);
      reflectedTarget =
          Offset(targetBall.dx, table.bottom - (targetBall.dy - table.bottom));
      break;
    default:
      return [cueBall, targetBall];
  }

  return [cueBall, bouncePoint, reflectedTarget];
}

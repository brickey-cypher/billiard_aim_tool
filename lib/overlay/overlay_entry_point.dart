import 'package:flutter/material.dart';
import '../screens/aim_line_screen.dart';

@pragma('vm:entry-point')
void overlayMain() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: true,
    home: AimLineScreen(),
  ));
}

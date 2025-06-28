import 'package:flutter/material.dart';
import '../screens/aim_line_screen.dart';

void overlayMain() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AimLineScreen(),
  ));
}

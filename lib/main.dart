// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/aim_line_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Billiard Aim Tool Dev',
    debugShowCheckedModeBanner: false,
    home: AimLineScreen(),
  ));
}

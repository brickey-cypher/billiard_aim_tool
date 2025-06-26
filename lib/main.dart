import 'package:flutter/material.dart';
import 'package:billiard_aim_tool/screens/aim_line_screen.dart';

void main() {
  runApp(const BilliardAimTool());
}

class BilliardAimTool extends StatelessWidget {
  const BilliardAimTool({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Billiard Aim Tool',
      home: AimLineScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

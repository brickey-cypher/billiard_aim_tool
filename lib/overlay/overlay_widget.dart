import 'package:flutter/material.dart';
import '../screens/aim_line_screen.dart'; // or wherever AimLineScreen is

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AimLineScreen(),
    );
  }
}

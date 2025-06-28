// lib/main_overlay.dart
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/aim_line_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Billiard Aim Tool',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billiard Aim Tool'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: const Text('Start Overlay'),
              onPressed: () async {
                debugPrint("🟨 Overlay button pressed");
                await _startOverlay();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.remove_red_eye),
              label: const Text('Preview AimLineScreen'),
              onPressed: () {
                debugPrint("🟦 Preview button pressed");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AimLineScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showPermissionDeniedDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _startOverlay() async {
    if (!await Permission.systemAlertWindow.isGranted) {
      debugPrint("❗ SYSTEM_ALERT_WINDOW not granted, requesting...");
      final result = await Permission.systemAlertWindow.request();
      if (!result.isGranted) {
        showPermissionDeniedDialog("System Alert Window permission is required.");
        return;
      }
    }

    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      debugPrint("❗ Overlay permission not granted, requesting...");
      await FlutterOverlayWindow.requestPermission();
      if (!await FlutterOverlayWindow.isPermissionGranted()) {
        showPermissionDeniedDialog("Overlay permission denied.");
        return;
      }
    }

    debugPrint("✅ All permissions granted. Showing overlay.");
    await FlutterOverlayWindow.showOverlay(
      height: 100,
      width: 100,
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      enableDrag: true,
      overlayTitle: 'Test',
      overlayContent: 'Basic overlay content',
    );
  }
}

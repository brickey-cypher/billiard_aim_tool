import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'overlay/overlay_entry.dart'; // Entry point for the overlay
import 'screens/aim_line_screen.dart'; // Needed for main app view if desired

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BilliardAimTool());
}

class BilliardAimTool extends StatelessWidget {
  const BilliardAimTool({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billiard Aim Tool',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                onPressed: _startOverlay,
              ),
              const SizedBox(height: 16), // spacing between buttons
              ElevatedButton.icon(
                icon: const Icon(Icons.remove_red_eye),
                label: const Text('Preview AimLineScreen'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AimLineScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startOverlay() async {
    // Check and request system alert window permission
    if (!await Permission.systemAlertWindow.isGranted) {
      final result = await Permission.systemAlertWindow.request();
      if (!result.isGranted) return;
    }

    // Request overlay permission via plugin if still not granted
    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.requestPermission();
    }

    // Launch the overlay with your custom entry point
    await FlutterOverlayWindow.showOverlay(
      height: 300,
      width: 400,
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      enableDrag: true,
      overlayTitle: 'Billiard Aim Tool',
      overlayContent: 'Aim overlay running',
    );
  }
}

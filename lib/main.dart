import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/aim_line_screen.dart'; // 👈 Make sure this path is correct for your project

// TODO: Replace the below import with the correct path to your AimLineScreen, or create the file if it doesn't exist.

class AimLineScreen extends StatelessWidget {
  const AimLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aim Line Overlay')),
    );
  }
}

/// 👇 This is the overlay entry point that launches your AimLineScreen in the overlay
@pragma('vm:entry-point')
void overlayMain() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AimLineScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billiard Aim Tool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Billiard Aim Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _startOverlay() async {
    final permission = await Permission.systemAlertWindow.status;

    if (!permission.isGranted) {
      final result = await Permission.systemAlertWindow.request();
      if (!result.isGranted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Overlay permission is required.')),
        );
        return;
      }
    }

    final isGranted = await FlutterOverlayWindow.isPermissionGranted();
    if (!isGranted) {
      await FlutterOverlayWindow.requestPermission();
    }

    await FlutterOverlayWindow.showOverlay(
      height: 300,
      width: 400,
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      enableDrag: true,
      // entryPoint: 'overlayMain', // 👈 this matches the function defined above
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _startOverlay,
          icon: const Icon(Icons.open_in_new),
          label: const Text('Start Overlay'),
        ),
      ),
    );
  }
}

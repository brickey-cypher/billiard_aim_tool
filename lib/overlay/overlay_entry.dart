import 'package:flutter/material.dart';
import 'overlay_widget.dart';
/// This must match the entry point name in `showOverlay()`

@pragma('vm:entry-point')
void overlayMain() {
  runApp(const OverlayWidget());
}

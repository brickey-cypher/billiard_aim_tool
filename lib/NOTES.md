# Billiard Aim Tool — Project Notes
## Common Commands

```bash
# Run desktop/browser dev version
    flutter run -t lib/main.dart -d chrome
# Run Android overlay version
    flutter run -t lib/main_overlay.dart -d android
# Build release APK
    flutter build apk --release
# Format all Dart files
    dart format lib/
# Analyze code for issues
    flutter analyze

Architecture Overview
    Core Logic: lib/logic/
    Contains all billiard mechanics and trajectory calculations.

UI Components:
    Screens: lib/screens/aim_line_screen.dart
    Widgets: lib/widgets/ (cue ball, target ball, etc.)
    Painters: lib/painters/ (table, trajectory rendering)

Overlay Logic:
    Entry point: lib/main_overlay.dart
    Overlay UI: lib/overlay/overlay_entry_point.dart
    Uses flutter_overlay_window and handles permissions.

Dev/Testing Entry Point:
    lib/main.dart (runs UI without overlay for fast iteration)

TODO
    Modularize aim line and bank shot logic further for easier unit testing
    Add unit and widget tests for trajectory and overlay permission flows
    Enhance error handling on permission denials with retry options
    Consider adding platform-specific config guards to isolate overlay code

Useful Tips
    Always use flutter run -t lib/main.dart for quick UI dev on desktop or web
    Use flutter run -t lib/main_overlay.dart when testing overlay features on Android devices
    Keep core logic independent from overlay and platform-specific code

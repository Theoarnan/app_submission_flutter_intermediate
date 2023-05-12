import 'package:flutter/foundation.dart';

class FlutterModeConfig {
  static bool get isDebug => kDebugMode;
  static bool get isRelease => kReleaseMode;
  static bool get isProfile => kProfileMode;

  static String get flutterMode => isDebug
      ? "Debug"
      : isRelease
          ? "Release"
          : isProfile
              ? "Profile"
              : "Unknown";
}

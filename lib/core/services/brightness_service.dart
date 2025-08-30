import 'package:screen_brightness/screen_brightness.dart';

class BrightnessService {
  double? _originalBrightness;

  /// Sets the screen brightness to maximum and saves the original brightness
  Future<void> setMaxBrightness() async {
    try {
      // Save original brightness
      _originalBrightness = await ScreenBrightness().current;
      // Set to maximum brightness
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (e) {
      // Handle permission or platform issues
      print('Failed to set brightness: $e');
    }
  }

  /// Restores the original brightness that was saved
  Future<void> restoreBrightness() async {
    try {
      if (_originalBrightness != null) {
        await ScreenBrightness().setScreenBrightness(_originalBrightness!);
      }
    } catch (e) {
      print('Failed to restore brightness: $e');
    }
  }
}

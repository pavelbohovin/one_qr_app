import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _imagePathKey = 'last_qr_image_path';
  static const String _zoomScaleKey = 'last_zoom_scale';
  static const String _zoomOffsetXKey = 'last_zoom_offset_x';
  static const String _zoomOffsetYKey = 'last_zoom_offset_y';

  /// Saves the last QR image path
  Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imagePathKey, path);
  }

  /// Loads the last QR image path
  Future<String?> loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imagePathKey);
  }

  /// Clears the saved image path
  Future<void> clearImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_imagePathKey);
  }

  /// Saves the zoom state (scale and offset)
  Future<void> saveZoomState(double scale, double offsetX, double offsetY) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_zoomScaleKey, scale);
    await prefs.setDouble(_zoomOffsetXKey, offsetX);
    await prefs.setDouble(_zoomOffsetYKey, offsetY);
  }

  /// Loads the saved zoom state
  Future<Map<String, double>> loadZoomState() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'scale': prefs.getDouble(_zoomScaleKey) ?? 1.0,
      'offsetX': prefs.getDouble(_zoomOffsetXKey) ?? 0.0,
      'offsetY': prefs.getDouble(_zoomOffsetYKey) ?? 0.0,
    };
  }
}

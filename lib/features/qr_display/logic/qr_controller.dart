import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/brightness_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/image_crop_service.dart';

class QRController extends ChangeNotifier {
  final BrightnessService _brightnessService = BrightnessService();
  final StorageService _storageService = StorageService();
  final ImageCropService _imageCropService = ImageCropService();

  File? _imageFile;
  File? _preCroppedImage;
  double _currentScale = 1.0;
  Offset _currentOffset = Offset.zero;
  bool _showScanningLine = false;
  bool _showFadeOut = false;

  // Getters
  File? get imageFile => _imageFile;
  File? get preCroppedImage => _preCroppedImage;
  double get currentScale => _currentScale;
  Offset get currentOffset => _currentOffset;
  bool get showScanningLine => _showScanningLine;
  bool get showFadeOut => _showFadeOut;

  /// Initialize the controller
  Future<void> initialize() async {
    await _brightnessService.setMaxBrightness();
    await _loadLastImage();
    await _loadLastZoomState();
  }

  /// Load the last saved image
  Future<void> _loadLastImage() async {
    final path = await _storageService.loadImagePath();
    if (path != null && File(path).existsSync()) {
      _imageFile = File(path);
      notifyListeners();
    }
  }

  /// Load the last saved zoom state
  Future<void> _loadLastZoomState() async {
    final zoomState = await _storageService.loadZoomState();
    _currentScale = zoomState['scale']!;
    _currentOffset = Offset(zoomState['offsetX']!, zoomState['offsetY']!);
    notifyListeners();
  }

  /// Save the current zoom state
  Future<void> saveZoomState() async {
    await _storageService.saveZoomState(_currentScale, _currentOffset.dx, _currentOffset.dy);
  }

  /// Update zoom state from transformation matrix
  void updateZoomState(double scale, Offset offset) {
    _currentScale = scale;
    _currentOffset = offset;
    saveZoomState();
    notifyListeners();
  }

  /// Pick an image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _currentScale = 1.0;
      _currentOffset = Offset.zero;
      _preCroppedImage = null;
      
      await _storageService.saveImagePath(pickedFile.path);
      await saveZoomState();
      
      // Pre-crop the image in background
      _preCropImage(File(pickedFile.path));
      
      notifyListeners();
    }
  }

  /// Close the current image
  Future<void> closeImage() async {
    _imageFile = null;
    _preCroppedImage = null;
    _currentScale = 1.0;
    _currentOffset = Offset.zero;
    _showScanningLine = false;
    _showFadeOut = false;
    
    await _storageService.clearImagePath();
    await saveZoomState();
    
    notifyListeners();
  }

  /// Pre-crop the image in background
  Future<void> _preCropImage(File imageFile) async {
    final croppedFile = await _imageCropService.preCropImage(imageFile);
    if (croppedFile != null) {
      _preCroppedImage = croppedFile;
      notifyListeners();
    }
  }

  /// Perform magic crop operation
  Future<void> magicCrop() async {
    if (_imageFile == null) return;

    _showScanningLine = true;
    notifyListeners();

    // Wait for scanning animation to complete
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Use pre-cropped image if available
      if (_preCroppedImage != null && _preCroppedImage!.existsSync()) {
        _showFadeOut = true;
        notifyListeners();
        
        await Future.delayed(const Duration(milliseconds: 300));
        
        _imageFile = _preCroppedImage;
        _currentScale = 1.0;
        _currentOffset = Offset.zero;
        _showScanningLine = false;
        _showFadeOut = false;
        
        await _storageService.saveImagePath(_preCroppedImage!.path);
        await saveZoomState();
        
        notifyListeners();
        return;
      }

      // Fallback to normal processing
      final croppedFile = await _imageCropService.cropImage(_imageFile!);
      if (croppedFile != null) {
        _showFadeOut = true;
        notifyListeners();
        
        await Future.delayed(const Duration(milliseconds: 300));
        
        _imageFile = croppedFile;
        _currentScale = 1.0;
        _currentOffset = Offset.zero;
        _showScanningLine = false;
        _showFadeOut = false;
        
        await _storageService.saveImagePath(croppedFile.path);
        await saveZoomState();
        
        notifyListeners();
      } else {
        _showScanningLine = false;
        notifyListeners();
      }
    } catch (e) {
      _showScanningLine = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Restore brightness when disposing
  @override
  Future<void> dispose() async {
    await _brightnessService.restoreBrightness();
    super.dispose();
  }
}

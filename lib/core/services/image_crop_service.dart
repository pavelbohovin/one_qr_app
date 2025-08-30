import 'dart:io';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageCropService {
  /// Pre-crops an image by detecting QR codes and cropping around them
  Future<File?> preCropImage(File imageFile) async {
    try {
      final scanner = BarcodeScanner();
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final barcodes = await scanner.processImage(inputImage);
      await scanner.close();

      if (barcodes.isEmpty) return null;

      // Prefer QR codes, otherwise take the first with a bounding box
      Barcode? target = barcodes.firstWhere(
        (b) => b.format == BarcodeFormat.qrCode && b.boundingBox != null,
        orElse: () => barcodes.firstWhere(
          (b) => b.boundingBox != null,
          orElse: () => barcodes.first,
        ),
      );

      final rect = target.boundingBox;
      if (rect == null) return null;

      final bytes = await imageFile.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;

      // Add padding around the detected rect
      const padding = 24;
      int x = (rect.left - padding).floor();
      int y = (rect.top - padding).floor();
      int w = (rect.width + padding * 2).ceil();
      int h = (rect.height + padding * 2).ceil();

      // Clamp to image bounds
      x = x.clamp(0, decoded.width - 1);
      y = y.clamp(0, decoded.height - 1);
      w = w.clamp(1, decoded.width - x);
      h = h.clamp(1, decoded.height - y);

      final cropped = img.copyCrop(decoded, x: x, y: y, width: w, height: h);
      final outDir = await getTemporaryDirectory();
      final outFile = File(
        '${outDir.path}/oneqr_precrop_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      final outBytes = img.encodeJpg(cropped, quality: 95);
      await outFile.writeAsBytes(outBytes);

      return outFile;
    } catch (e) {
      // Silently handle pre-crop errors
      print('Pre-crop failed: $e');
      return null;
    }
  }

  /// Crops an image by detecting QR codes and cropping around them
  Future<File?> cropImage(File imageFile) async {
    try {
      final scanner = BarcodeScanner();
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final barcodes = await scanner.processImage(inputImage);
      await scanner.close();

      if (barcodes.isEmpty) return null;

      // Prefer QR codes, otherwise take the first with a bounding box
      Barcode? target = barcodes.firstWhere(
        (b) => b.format == BarcodeFormat.qrCode && b.boundingBox != null,
        orElse: () => barcodes.firstWhere(
          (b) => b.boundingBox != null,
          orElse: () => barcodes.first,
        ),
      );

      final rect = target.boundingBox;
      if (rect == null) return null;

      final bytes = await imageFile.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;

      // Add padding around the detected rect
      const padding = 24;
      int x = (rect.left - padding).floor();
      int y = (rect.top - padding).floor();
      int w = (rect.width + padding * 2).ceil();
      int h = (rect.height + padding * 2).ceil();

      // Clamp to image bounds
      x = x.clamp(0, decoded.width - 1);
      y = y.clamp(0, decoded.height - 1);
      w = w.clamp(1, decoded.width - x);
      h = h.clamp(1, decoded.height - y);

      final cropped = img.copyCrop(decoded, x: x, y: y, width: w, height: h);
      final outDir = await getTemporaryDirectory();
      final outFile = File(
        '${outDir.path}/oneqr_crop_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      final outBytes = img.encodeJpg(cropped, quality: 95);
      await outFile.writeAsBytes(outBytes);

      return outFile;
    } catch (e) {
      print('Crop failed: $e');
      return null;
    }
  }
}

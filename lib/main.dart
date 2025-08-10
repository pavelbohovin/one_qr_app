import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const OneQRApp());
}

class OneQRApp extends StatelessWidget {
  const OneQRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One QR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('en', 'US'), // American English
        Locale('en', 'GB'), // British English
        Locale('es'), // Spanish
        Locale('es', 'MX'), // Mexican Spanish
        Locale('fr'), // French
        Locale('fr', 'CA'), // Canadian French
        Locale('de'), // German
        Locale('de', 'AT'), // Austrian German
        Locale('de', 'CH'), // Swiss German
        Locale('it'), // Italian
        Locale('it', 'CH'), // Swiss Italian
        Locale('pt'), // Portuguese
        Locale('pt', 'BR'), // Brazilian Portuguese
        Locale('nl'), // Dutch
        Locale('nl', 'BE'), // Belgian Dutch
        Locale('sv'), // Swedish
        Locale('sv', 'FI'), // Finland Swedish
        Locale('no'), // Norwegian
        Locale('nb'), // Norwegian Bokmål
        Locale('nn'), // Norwegian Nynorsk
        Locale('da'), // Danish
        Locale('fi'), // Finnish
        Locale('is'), // Icelandic
        Locale('fo'), // Faroese
        Locale('kl'), // Greenlandic
        Locale('ga'), // Irish
        Locale('gd'), // Scottish Gaelic
        Locale('gv'), // Manx
        Locale('cy'), // Welsh
        Locale('br'), // Breton
        Locale('kw'), // Cornish
        Locale('fy'), // Frisian
        Locale('lb'), // Luxembourgish
        Locale('rm'), // Romansh
        Locale('oc'), // Occitan
        Locale('ca'), // Catalan
        Locale('eu'), // Basque
        Locale('gl'), // Galician
        Locale('ast'), // Asturian
        Locale('an'), // Aragonese
        Locale('mwl'), // Mirandese
        Locale('lad'), // Ladino
        Locale('yi'), // Yiddish
        Locale('ru'), // Russian
        Locale('uk'), // Ukrainian
        Locale('be'), // Belarusian
        Locale('pl'), // Polish
        Locale('cs'), // Czech
        Locale('sk'), // Slovak
        Locale('hr'), // Croatian
        Locale('sl'), // Slovenian
        Locale('bg'), // Bulgarian
        Locale('mk'), // Macedonian
        Locale('sq'), // Albanian
        Locale('sr'), // Serbian
        Locale('bs'), // Bosnian
        Locale('ro'), // Romanian
        Locale('mo'), // Moldovan
        Locale('gag'), // Gagauz
        Locale('rom'), // Romani
        Locale('hu'), // Hungarian
        Locale('et'), // Estonian
        Locale('lv'), // Latvian
        Locale('lt'), // Lithuanian
        Locale('el'), // Greek
        Locale('tr'), // Turkish
        Locale('az'), // Azerbaijani
        Locale('ka'), // Georgian
        Locale('hy'), // Armenian
        Locale('kk'), // Kazakh
        Locale('ky'), // Kyrgyz
        Locale('uz'), // Uzbek
        Locale('tg'), // Tajik
        Locale('tk'), // Turkmen
        Locale('ug'), // Uyghur
        Locale('mn'), // Mongolian
        Locale('bo'), // Tibetan
        Locale('zh'), // Chinese Simplified
        Locale('zh', 'TW'), // Chinese Traditional (Taiwan)
        Locale('zh', 'HK'), // Chinese Traditional (Hong Kong)
        Locale('ja'), // Japanese
        Locale('ko'), // Korean
        Locale('ar'), // Arabic
        Locale('he'), // Hebrew
        Locale('fa'), // Persian
        Locale('ps'), // Pashto
        Locale('prs'), // Dari
        Locale('ku'), // Kurdish
        Locale('bal'), // Balochi
        Locale('brh'), // Brahui
        Locale('sd'), // Sindhi
        Locale('ur'), // Urdu
        Locale('skr'), // Saraiki
        Locale('hno'), // Hindko
        Locale('ks'), // Kashmiri
        Locale('doi'), // Dogri
        Locale('kok'), // Konkani
        Locale('mni'), // Manipuri
        Locale('sa'), // Sanskrit
        Locale('hi'), // Hindi
        Locale('bn'), // Bengali
        Locale('as'), // Assamese
        Locale('or'), // Odia
        Locale('mr'), // Marathi
        Locale('gu'), // Gujarati
        Locale('pa'), // Punjabi
        Locale('ne'), // Nepali
        Locale('si'), // Sinhala
        Locale('dv'), // Dhivehi/Maldivian
        Locale('ta'), // Tamil
        Locale('te'), // Telugu
        Locale('ml'), // Malayalam
        Locale('kn'), // Kannada
        Locale('tcy'), // Tulu
        Locale('kfa'), // Kodava
        Locale('ms'), // Malay
        Locale('id'), // Indonesian
        Locale('jv'), // Javanese
        Locale('su'), // Sundanese
        Locale('ban'), // Balinese
        Locale('ace'), // Acehnese
        Locale('min'), // Minangkabau
        Locale('th'), // Thai
        Locale('lo'), // Lao
        Locale('km'), // Khmer
        Locale('vi'), // Vietnamese
        Locale('my'), // Burmese
        Locale('qu'), // Quechua
        Locale('am'), // Amharic
      ],
      home: const QRImagePage(),
    );
  }
}

class QRImagePage extends StatefulWidget {
  const QRImagePage({super.key});

  @override
  State<QRImagePage> createState() => _QRImagePageState();
}

class _QRImagePageState extends State<QRImagePage> with TickerProviderStateMixin {
  File? _imageFile;
  static const String _imagePathKey = 'last_qr_image_path';
  static const String _zoomScaleKey = 'last_zoom_scale';
  static const String _zoomOffsetXKey = 'last_zoom_offset_x';
  static const String _zoomOffsetYKey = 'last_zoom_offset_y';
  
  double _currentScale = 1.0;
  Offset _currentOffset = Offset.zero;
  final TransformationController _transformationController = TransformationController();
  bool _showScanningLine = false;
  late AnimationController _scanningAnimationController;
  late Animation<double> _scanningAnimation;

  @override
  void initState() {
    super.initState();
    _scanningAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scanningAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scanningAnimationController,
      curve: Curves.easeInOut,
    ));
    _loadLastImage();
    _loadLastZoomState();
  }

  Future<void> _loadLastImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_imagePathKey);
    if (path != null && File(path).existsSync()) {
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> _loadLastZoomState() async {
    final prefs = await SharedPreferences.getInstance();
    final scale = prefs.getDouble(_zoomScaleKey) ?? 1.0;
    final offsetX = prefs.getDouble(_zoomOffsetXKey) ?? 0.0;
    final offsetY = prefs.getDouble(_zoomOffsetYKey) ?? 0.0;
    
    setState(() {
      _currentScale = scale;
      _currentOffset = Offset(offsetX, offsetY);
    });
    
    // Apply the saved transformation after a short delay to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _transformationController.value = Matrix4.identity()
        ..translate(_currentOffset.dx, _currentOffset.dy)
        ..scale(_currentScale);
    });
  }

  Future<void> _saveZoomState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_zoomScaleKey, _currentScale);
    await prefs.setDouble(_zoomOffsetXKey, _currentOffset.dx);
    await prefs.setDouble(_zoomOffsetYKey, _currentOffset.dy);
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    final matrix = _transformationController.value;
    setState(() {
      _currentScale = matrix.getMaxScaleOnAxis();
      _currentOffset = Offset(matrix.getTranslation().x, matrix.getTranslation().y);
    });
    _saveZoomState();
  }

  void _onDoubleTapDown(TapDownDetails details) {
    if (_currentScale <= 1.0) {
      // Zoom in by 50% to the tapped point
      final newScale = _currentScale * 1.5;
      _animateToScaleAtPoint(newScale, details.localPosition);
    } else {
      // Zoom out to initial state
      _animateToScale(1.0);
    }
  }

  void _animateToScale(double targetScale) {
    final animation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    final animationCurve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    final initialScale = _currentScale;
    final initialOffset = _currentOffset;

    animation.addListener(() {
      final progress = animationCurve.value;
      
      // Interpolate scale
      final interpolatedScale = initialScale + (targetScale - initialScale) * progress;
      
      // Interpolate offset (only when zooming out to reset position)
      final interpolatedOffset = targetScale == 1.0 
          ? Offset.lerp(initialOffset, Offset.zero, progress)!
          : initialOffset;
      
      // Create interpolated matrix
      final interpolatedMatrix = Matrix4.identity()
        ..translate(interpolatedOffset.dx, interpolatedOffset.dy)
        ..scale(interpolatedScale);
      
      _transformationController.value = interpolatedMatrix;
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentScale = targetScale;
          if (targetScale == 1.0) {
            _currentOffset = Offset.zero;
          }
        });
        _saveZoomState();
        animation.dispose();
      }
    });

    animation.forward();
  }

  void _animateToScaleAtPoint(double targetScale, Offset tapPoint) {
    final animation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    final animationCurve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    final initialScale = _currentScale;
    final initialOffset = _currentOffset;

    // Get the current widget size to calculate proper coordinates
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final widgetSize = renderBox.size;
    
    // Calculate the center of the widget
    final widgetCenter = Offset(widgetSize.width / 2, widgetSize.height / 2);
    
    // Calculate the tap point relative to the widget center
    final tapPointFromCenter = tapPoint - widgetCenter;
    
    // To center the tapped point, we need to move the image so that the tapped point
    // becomes the center of the view. The offset should be the negative of the tap point
    // multiplied by the scale factor
    final targetOffset = Offset(
      -tapPointFromCenter.dx * targetScale,
      -tapPointFromCenter.dy * targetScale,
    );

    animation.addListener(() {
      final progress = animationCurve.value;
      
      // Interpolate scale
      final interpolatedScale = initialScale + (targetScale - initialScale) * progress;
      
      // Interpolate offset
      final interpolatedOffset = Offset.lerp(initialOffset, targetOffset, progress)!;
      
      // Create interpolated matrix
      final interpolatedMatrix = Matrix4.identity()
        ..translate(interpolatedOffset.dx, interpolatedOffset.dy)
        ..scale(interpolatedScale);
      
      _transformationController.value = interpolatedMatrix;
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentScale = targetScale;
          _currentOffset = targetOffset;
        });
        _saveZoomState();
        animation.dispose();
      }
    });

    animation.forward();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        // Reset zoom when new image is selected
        _currentScale = 1.0;
        _currentOffset = Offset.zero;
        _transformationController.value = Matrix4.identity();
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imagePathKey, pickedFile.path);
      await _saveZoomState();
    }
  }

  Future<void> _magicCrop() async {
    if (_imageFile == null) {
      return;
    }

    // Start scanning animation
    setState(() {
      _showScanningLine = true;
    });
    _scanningAnimationController.reset();
    _scanningAnimationController.forward();

    // Wait for scanning animation to complete
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final scanner = BarcodeScanner();
      final inputImage = InputImage.fromFilePath(_imageFile!.path);
      final barcodes = await scanner.processImage(inputImage);
      await scanner.close();

      if (barcodes.isEmpty) {
        if (mounted) {
          setState(() {
            _showScanningLine = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.noQrImageSelected)),
          );
        }
        return;
      }

      // Prefer QR codes, otherwise take the first with a bounding box
      Barcode? target = barcodes.firstWhere(
        (b) => b.format == BarcodeFormat.qrCode && b.boundingBox != null,
        orElse: () => barcodes.firstWhere(
          (b) => b.boundingBox != null,
          orElse: () => barcodes.first,
        ),
      );

      final rect = target.boundingBox;
      if (rect == null) {
        if (mounted) {
          setState(() {
            _showScanningLine = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No detectable bounding box.')),
          );
        }
        return;
      }

      final bytes = await _imageFile!.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to decode image.')),
          );
        }
        return;
      }

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

      if (!mounted) return;
      setState(() {
        _imageFile = outFile;
        _currentScale = 1.0;
        _currentOffset = Offset.zero;
        _transformationController.value = Matrix4.identity();
        _showScanningLine = false;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imagePathKey, outFile.path);
      await _saveZoomState();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Magic failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: _imageFile != null
                ? InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    transformationController: _transformationController,
                    onInteractionUpdate: _onInteractionUpdate,
                    child: GestureDetector(
                      onDoubleTapDown: _onDoubleTapDown,
                      child: Image.file(_imageFile!, width: 600, height: 800, fit: BoxFit.contain),
                    ),
                  )
                : Text(AppLocalizations.of(context)!.noQrImageSelected),
          ),
          // Scanning line overlay
          if (_showScanningLine)
            AnimatedBuilder(
              animation: _scanningAnimation,
              builder: (context, child) {
                return Positioned.fill(
                  child: CustomPaint(
                    painter: ScanningLinePainter(
                      progress: _scanningAnimation.value,
                    ),
                  ),
                );
              },
            ),
          // MagicCrop button - only show when image is selected and not already cropped
          if (_imageFile != null && !_imageFile!.path.contains('oneqr_crop_'))
            Positioned(
              left: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: _magicCrop,
                heroTag: "magicCrop",
                child: Image.asset(
                  'assets/icons/autocrop_qr_code_icon.png',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: AppLocalizations.of(context)!.uploadQrImage,
        child: const Icon(Icons.upload),
      ),
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _scanningAnimationController.dispose();
    super.dispose();
  }
}

class ScanningLinePainter extends CustomPainter {
  final double progress;

  ScanningLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the scanning line position (from top to bottom of screen)
    final lineY = size.height * progress;
    
    // Draw the scanning line across the full screen width
    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw the main line from left edge to right edge of screen
    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      linePaint,
    );

    // Draw glow effect
    final glowPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      glowPaint,
    );

    // Draw scanning dots at the ends
    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final dotRadius = 6.0;
    canvas.drawCircle(Offset(0, lineY), dotRadius, dotPaint);
    canvas.drawCircle(Offset(size.width, lineY), dotRadius, dotPaint);
  }

  @override
  bool shouldRepaint(ScanningLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

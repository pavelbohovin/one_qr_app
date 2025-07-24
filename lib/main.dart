import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
    super.dispose();
  }
}

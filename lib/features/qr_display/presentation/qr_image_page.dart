import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../logic/qr_controller.dart';
import '../../../core/widgets/scanning_line_painter.dart';

class QRImagePage extends StatefulWidget {
  const QRImagePage({super.key});

  @override
  State<QRImagePage> createState() => _QRImagePageState();
}

class _QRImagePageState extends State<QRImagePage> with TickerProviderStateMixin {
  late QRController _controller;
  final TransformationController _transformationController = TransformationController();
  late AnimationController _scanningAnimationController;
  late Animation<double> _scanningAnimation;
  late AnimationController _fadeOutAnimationController;
  late Animation<double> _fadeOutAnimation;

  @override
  void initState() {
    super.initState();
    _controller = QRController();
    _controller.addListener(_onControllerChanged);
    
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
    
    _fadeOutAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeOutAnimationController,
      curve: Curves.easeOut,
    ));
    
    _controller.initialize();
    _loadLastZoomState();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadLastZoomState() async {
    // Apply the saved transformation after a short delay to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _transformationController.value = Matrix4.identity()
        ..translate(_controller.currentOffset.dx, _controller.currentOffset.dy)
        ..scale(_controller.currentScale);
    });
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    final matrix = _transformationController.value;
    _controller.updateZoomState(
      matrix.getMaxScaleOnAxis(),
      Offset(matrix.getTranslation().x, matrix.getTranslation().y),
    );
  }

  void _onDoubleTapDown(TapDownDetails details) {
    if (_controller.currentScale <= 1.0) {
      // Zoom in by 50% to the tapped point
      final newScale = _controller.currentScale * 1.5;
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

    final initialScale = _controller.currentScale;
    final initialOffset = _controller.currentOffset;

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
        _controller.updateZoomState(targetScale, targetScale == 1.0 ? Offset.zero : initialOffset);
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

    final initialScale = _controller.currentScale;
    final initialOffset = _controller.currentOffset;

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
        _controller.updateZoomState(targetScale, targetOffset);
        animation.dispose();
      }
    });

    animation.forward();
  }

  Future<void> _magicCrop() async {
    try {
      // Start the scanning animation
      _scanningAnimationController.reset();
      _scanningAnimationController.forward();
      
      await _controller.magicCrop();
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Center(
            child: _controller.imageFile != null
                ? AnimatedBuilder(
                    animation: _fadeOutAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _controller.showFadeOut ? _fadeOutAnimation.value : 1.0,
                        child: InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 4.0,
                          transformationController: _transformationController,
                          onInteractionUpdate: _onInteractionUpdate,
                          child: GestureDetector(
                            onDoubleTapDown: _onDoubleTapDown,
                            child: Image.file(_controller.imageFile!, width: 600, height: 800, fit: BoxFit.contain),
                          ),
                        ),
                      );
                    },
                  )
                : Text(
                    AppLocalizations.of(context)!.noQrImageSelected,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
          ),
          // Close button - only show when image is selected
          if (_controller.imageFile != null)
            Positioned(
              top: 48,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: _controller.closeImage,
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 24,
                  ),
                  tooltip: 'Close image',
                ),
              ),
            ),
          // Scanning line overlay
          if (_controller.showScanningLine)
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
        ],
      ),
      floatingActionButton: _controller.imageFile != null && 
          !_controller.imageFile!.path.contains('oneqr_crop_') && 
          !_controller.imageFile!.path.contains('oneqr_precrop_')
          ? AnimatedBuilder(
              animation: _fadeOutAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller.showFadeOut ? _fadeOutAnimation.value : 1.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: FloatingActionButton(
                          onPressed: _magicCrop,
                          heroTag: "magicCrop",
                          child: Image.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/icons/autocrop_qr_code_white_icon.png'
                                : 'assets/icons/autocrop_qr_code_icon.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: _controller.pickImage,
                        tooltip: AppLocalizations.of(context)!.uploadQrImage,
                        child: const Icon(Icons.upload),
                      ),
                    ],
                  ),
                );
              },
            )
          : FloatingActionButton(
              onPressed: _controller.pickImage,
              tooltip: AppLocalizations.of(context)!.uploadQrImage,
              child: const Icon(Icons.upload),
            ),
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _scanningAnimationController.dispose();
    _fadeOutAnimationController.dispose();
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

class ScanningLinePainter extends CustomPainter {
  final double progress;

  ScanningLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the scanning line position (from top to bottom of screen)
    final lineY = size.height * progress;
    
    // Draw gradient shadow trailing behind the line
    final shadowHeight = 80.0;
    final shadowStartY = lineY - shadowHeight;
    
    // Create gradient from blue to transparent
    final shadowGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue.withOpacity(0.0),
        Colors.blue.withOpacity(0.4),
        Colors.blue.withOpacity(0.8),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
    
    // Draw gradient shadow rectangle
    final shadowRect = Rect.fromLTWH(0, shadowStartY, size.width, shadowHeight);
    final shadowPaint = Paint()
      ..shader = shadowGradient.createShader(shadowRect);
    
    canvas.drawRect(shadowRect, shadowPaint);
    
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

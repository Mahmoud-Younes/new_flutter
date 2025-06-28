import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/detection_result.dart';

class DetectionPainter extends CustomPainter {
  final ui.Image image;
  final List<DetectionResult> detections;

  DetectionPainter({required this.image, required this.detections});

  @override
  void paint(Canvas canvas, Size size) {
    final imageRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final srcRect = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    canvas.drawImageRect(
      image,
      srcRect,
      imageRect,
      Paint()..filterQuality = FilterQuality.high,
    );

    final scaleX = size.width / image.width;
    final scaleY = size.height / image.height;

    for (int i = 0; i < detections.length; i++) {
      final detection = detections[i];
      _drawDetection(canvas, detection, scaleX, scaleY, i + 1);
    }
  }

  void _drawDetection(
    Canvas canvas,
    DetectionResult detection,
    double scaleX,
    double scaleY,
    int index,
  ) {
    final x = detection.x * scaleX;
    final y = detection.y * scaleY;
    final width = detection.width * scaleX;
    final height = detection.height * scaleY;

    final rect = Rect.fromLTWH(x, y, width, height);

    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.amber,
    ];
    final color = colors[index % colors.length];

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;

    canvas.drawRect(rect, paint);

    final labelText =
        '${detection.className} ${(detection.confidence * 100).toStringAsFixed(1)}%';
    final textPainter = TextPainter(
      text: TextSpan(
        text: labelText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final labelX = x;
    final labelY = y - textPainter.height - 4;

    final backgroundRect = Rect.fromLTWH(
      labelX - 2,
      labelY - 2,
      textPainter.width + 4,
      textPainter.height + 4,
    );

    final backgroundPaint = Paint()..color = color;
    canvas.drawRect(backgroundRect, backgroundPaint);

    textPainter.paint(canvas, Offset(labelX, labelY));

    final indexText = '$index';
    final indexPainter = TextPainter(
      text: TextSpan(
        text: indexText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    indexPainter.layout();

    final circleCenter = Offset(x + width - 15, y + 15);
    final circlePaint = Paint()..color = color;
    canvas.drawCircle(circleCenter, 12, circlePaint);

    indexPainter.paint(
      canvas,
      Offset(
        circleCenter.dx - indexPainter.width / 2,
        circleCenter.dy - indexPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'detection_painter.dart';
import '../models/detection_result.dart';

class DetectionViewer extends StatefulWidget {
  final File imageFile;
  final List<DetectionResult> detections;

  const DetectionViewer({
    super.key,
    required this.imageFile,
    required this.detections,
  });

  @override
  State<DetectionViewer> createState() => _DetectionViewerState();
}

class _DetectionViewerState extends State<DetectionViewer> {
  ui.Image? _uiImage;

  @override
  void initState() {
    super.initState();
    _loadUiImage(widget.imageFile);
  }

  Future<void> _loadUiImage(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    setState(() {
      _uiImage = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uiImage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomPaint(
      painter: DetectionPainter(
        image: _uiImage!,
        detections: widget.detections,
      ),
      size: Size(
        _uiImage!.width.toDouble(),
        _uiImage!.height.toDouble(),
      ),
    );
  }
}
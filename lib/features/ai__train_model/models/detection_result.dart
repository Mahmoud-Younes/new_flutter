class DetectionResult {
  final String className;
  final double confidence;
  final double x;
  final double y;
  final double width;
  final double height;

  DetectionResult({
    required this.className,
    required this.confidence,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  @override
  String toString() {
    return 'DetectionResult{className: $className, confidence: $confidence, '
        'x: $x, y: $y, width: $width, height: $height}';
  }

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'confidence': confidence,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }

  factory DetectionResult.fromMap(Map<String, dynamic> map) {
    return DetectionResult(
      className: map['className'] ?? '',
      confidence: map['confidence']?.toDouble() ?? 0.0,
      x: map['x']?.toDouble() ?? 0.0,
      y: map['y']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
    );
  }
}
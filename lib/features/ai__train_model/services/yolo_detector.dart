import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../models/detection_result.dart';

class YoloDetector {
  Interpreter? _interpreter;
  List<String> _labels = [];

  static const int inputSize = 640;
  static const double confidenceThreshold = 0.25;
  static const double iouThreshold = 0.45;

  Future<void> loadModel() async {
    try {
      // تحميل النموذج
      _interpreter = await Interpreter.fromAsset(
        'assets/tflite/best_float32.tflite',
      );

      // تحميل التسميات
      final labelsData = await rootBundle.loadString(
        'assets/tflite/labels.txt',
      );
      _labels = labelsData
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.trim())
          .toList();

      print('Model loaded successfully');
      print('Input shape: ${_interpreter!.getInputTensor(0).shape}');
      print('Output shape: ${_interpreter!.getOutputTensor(0).shape}');
      print('Labels loaded: ${_labels.length}');
      print('Labels: $_labels');
      
    } catch (e) {
      print('Error loading model: $e');
      rethrow;
    }
  }

  Future<List<DetectionResult>> detectObjects(File imageFile) async {
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }

    try {
      // قراءة وفك تشفير الصورة
      final imageBytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // حفظ الأبعاد الأصلية
      final originalWidth = image.width;
      final originalHeight = image.height;
      print('Original image size: ${originalWidth}x${originalHeight}');

      // تغيير حجم الصورة
      final resizedImage = img.copyResize(
        image,
        width: inputSize,
        height: inputSize,
      );

      // تحويل إلى tensor دخل - الإصلاح الرئيسي هنا
      final input = _imageToTensor(resizedImage);

      // تحضير tensor الخرج
      final outputShape = _interpreter!.getOutputTensor(0).shape;
      print('Output shape: $outputShape');

      // إنشاء مصفوفة الخرج بالشكل الصحيح
      final output = List.generate(
        outputShape[0],
        (i) => List.generate(
          outputShape[1],
          (j) => List.generate(outputShape[2], (k) => 0.0),
        ),
      );

      // تشغيل التنبؤ
      final stopwatch = Stopwatch()..start();
      _interpreter!.run(input, output);
      stopwatch.stop();
      print('Inference time: ${stopwatch.elapsedMilliseconds}ms');

      // معالجة النتائج
      return _processOutput(output[0], originalWidth, originalHeight);
    } catch (e) {
      print('Error during detection: $e');
      rethrow;
    }
  }

  // الدالة المحدثة لتحويل الصورة إلى tensor بالشكل الصحيح
  List<List<List<List<double>>>> _imageToTensor(img.Image image) {
    // إنشاء tensor بالشكل [1, 640, 640, 3]
    final tensor = List.generate(
      1, // batch size
      (batch) => List.generate(
        inputSize, // height
        (y) => List.generate(
          inputSize, // width
          (x) => List.generate(3, (c) => 0.0), // channels (RGB)
        ),
      ),
    );

    // ملء البيانات
    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);
        
        // استخراج قيم RGB وتطبيعها
        tensor[0][y][x][0] = pixel.r / 255.0; // Red
        tensor[0][y][x][1] = pixel.g / 255.0; // Green  
        tensor[0][y][x][2] = pixel.b / 255.0; // Blue
      }
    }

    return tensor;
  }

  List<DetectionResult> _processOutput(
    List<List<double>> output,
    int originalWidth,
    int originalHeight,
  ) {
    final detections = <DetectionResult>[];

    // تحديد عدد التنبؤات والفئات
    final numClasses = output.length - 4; // أول 4 صفوف للصناديق
    final numPredictions = output[0].length;

    print('Processing $numPredictions predictions with $numClasses classes');

    for (int i = 0; i < numPredictions; i++) {
      // استخراج إحداثيات الصندوق (center_x, center_y, width, height)
      final centerX = output[0][i];
      final centerY = output[1][i];
      final width = output[2][i];
      final height = output[3][i];

      // العثور على أفضل فئة ومستوى الثقة
      double maxConfidence = 0.0;
      int bestClassIndex = 0;

      for (int j = 4; j < 4 + numClasses; j++) {
        if (output[j][i] > maxConfidence) {
          maxConfidence = output[j][i];
          bestClassIndex = j - 4;
        }
      }

      if (maxConfidence > confidenceThreshold) {
        // تحويل إلى إحداثيات الصورة الأصلية
        final scaleX = originalWidth / inputSize;
        final scaleY = originalHeight / inputSize;

        final x = (centerX - width / 2) * scaleX;
        final y = (centerY - height / 2) * scaleY;
        final w = width * scaleX;
        final h = height * scaleY;

        final className = bestClassIndex < _labels.length
            ? _labels[bestClassIndex]
            : 'Unknown';

        detections.add(
          DetectionResult(
            className: className,
            confidence: maxConfidence,
            x: math.max(0, x),
            y: math.max(0, y),
            width: math.min(w, originalWidth - x),
            height: math.min(h, originalHeight - y),
          ),
        );
      }
    }

    print('Found ${detections.length} detections before NMS');

    // تطبيق Non-Maximum Suppression
    final nmsResults = _applyNMS(detections);
    print('After NMS: ${nmsResults.length} detections');

    return nmsResults;
  }

  List<DetectionResult> _applyNMS(List<DetectionResult> detections) {
    if (detections.isEmpty) return [];

    // ترتيب حسب مستوى الثقة
    detections.sort((a, b) => b.confidence.compareTo(a.confidence));

    final results = <DetectionResult>[];
    final suppressed = List<bool>.filled(detections.length, false);

    for (int i = 0; i < detections.length; i++) {
      if (suppressed[i]) continue;

      results.add(detections[i]);

      // قمع الصناديق المتداخلة
      for (int j = i + 1; j < detections.length; j++) {
        if (suppressed[j]) continue;

        final iou = _calculateIoU(detections[i], detections[j]);
        if (iou > iouThreshold) {
          suppressed[j] = true;
        }
      }
    }

    return results;
  }

  double _calculateIoU(DetectionResult a, DetectionResult b) {
    final x1 = math.max(a.x, b.x);
    final y1 = math.max(a.y, b.y);
    final x2 = math.min(a.x + a.width, b.x + b.width);
    final y2 = math.min(a.y + a.height, b.y + b.height);

    if (x2 <= x1 || y2 <= y1) {
      return 0.0;
    }

    final intersection = (x2 - x1) * (y2 - y1);
    final union = a.width * a.height + b.width * b.height - intersection;

    return intersection / union;
  }

  void dispose() {
    _interpreter?.close();
  }
}
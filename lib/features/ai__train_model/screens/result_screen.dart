import 'dart:io';
import 'package:flutter/material.dart';
import '../models/detection_result.dart';
import '../widgets/detection_viewer.dart';
import '../models/artifact_info.dart';

class ResultScreen extends StatelessWidget {
  final String imagePath;
  final List<DetectionResult> detections;

  const ResultScreen({
    super.key,
    required this.imagePath,
    required this.detections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة التحليل'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الصورة مع الرسومات
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: DetectionViewer(
                      imageFile: File(imagePath),
                      detections: detections,
                    ),
                  ),
                ),
              ),
            ),

            // ملخص النتائج
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'نتيجة التحليل:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'عدد الكائنات المكتشفة: ${detections.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // تفاصيل الكائنات المكتشفة
            if (detections.isNotEmpty) ...[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تفاصيل الكائنات المكتشفة:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...detections.asMap().entries.map((entry) {
                          final index = entry.key;
                          final detection = entry.value;
                          return _buildDetectionCard(index + 1, detection);
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: Colors.orange.shade600,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'لم يتم العثور على أي آثار في هذه الصورة',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            ...detections.map((detection) {
              final artifact = ArtifactInfoDatabase.getInfo(
                detection.className,
              );
              if (artifact == null) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('لا توجد معلومات مفصلة لهذا الكشف.'),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(artifact.arabicName),
                        const SizedBox(height: 8),
                        Text(artifact.description),
                        const SizedBox(height: 8),
                        Text("الفترة: " + artifact.period),
                        Text("الموقع: " + artifact.location),
                        Text("المادة: " + artifact.material),
                        const SizedBox(height: 8),
                        Text("الأهمية: " + artifact.significance),
                        const SizedBox(height: 8),
                        Text("حقائق:"),
                        ...artifact.facts
                            .map((fact) => Text("• $fact"))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.camera_alt),
        tooltip: 'تحليل صورة جديدة',
      ),
    );
  }

  Widget _buildDetectionCard(int index, DetectionResult detection) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'الكائن: ${detection.className}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'نسبة الثقة: ${(detection.confidence * 100).toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'الموقع: X=${detection.x.toStringAsFixed(1)}, Y=${detection.y.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'الحجم: ${detection.width.toStringAsFixed(1)}×${detection.height.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

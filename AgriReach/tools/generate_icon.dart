import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Create a canvas to draw the icon
  final canvasSize = 1024.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, canvasSize, canvasSize));
  
  // Draw background
  final paint = Paint()..color = const Color(0xFF4CAF50); // Green color
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, canvasSize, canvasSize),
      Radius.circular(canvasSize * 0.2),
    ),
    paint,
  );

  // Draw a leaf icon
  final leafPaint = Paint()..color = Colors.white;
  final leafPath = Path()
    ..moveTo(canvasSize * 0.5, canvasSize * 0.1)
    ..quadraticBezierTo(
      canvasSize * 0.15,
      canvasSize * 0.4,
      canvasSize * 0.3,
      canvasSize * 0.7,
    )
    ..quadraticBezierTo(
      canvasSize * 0.5,
      canvasSize * 0.9,
      canvasSize * 0.7,
      canvasSize * 0.7,
    )
    ..quadraticBezierTo(
      canvasSize * 0.85,
      canvasSize * 0.4,
      canvasSize * 0.5,
      canvasSize * 0.1,
    );
  canvas.drawPath(leafPath, leafPaint);

  // Convert to image and save
  final picture = recorder.endRecording();
  final img = await picture.toImage(canvasSize.toInt(), canvasSize.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();
  
  // Save the icon
  final file = File('assets/icon/icon.png');
  await file.create(recursive: true);
  await file.writeAsBytes(buffer);
  
  print('Icon generated at ${file.path}');
}

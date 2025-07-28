import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async {
  // Create a canvas to draw the foreground icon
  final canvasSize = 108.0; // 108dp x 108dp for adaptive icon foreground
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, canvasSize, canvasSize));
  
  // Draw a white leaf icon (foreground)
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
  
  // Save the foreground icon
  final file = File('assets/icon/icon_foreground.png');
  await file.create(recursive: true);
  await file.writeAsBytes(buffer);
  
  print('Foreground icon generated at ${file.path}');
}

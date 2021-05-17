import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// text를 picture로 바꿈
class TextToPictureConverter {
  // ui.Picture : recorded 그래픽 연산의 시퀀스
  static ui.Picture convert({
    required String text,
    required double canvasSize,
    required bool border,
  }) {
    // recorder
    // picture를 만드는 법
    // Canvas 만들때 선언
    final recorder = ui.PictureRecorder();

    // canvas
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        Offset(0.0, 0.0),
        Offset(canvasSize, canvasSize),
      ),
    );

    final Color color = Colors.white;

    /// 경계선
    if (border) {
      final stroke = Paint()
        ..color = color
        ..style = PaintingStyle.stroke;

      canvas.drawRect(Rect.fromLTWH(0.0, 0.0, canvasSize, canvasSize), stroke);
    }

    /// textspan
    TextSpan span = TextSpan(
      style: TextStyle(
        fontFamily: "Monospace",
        color: color,
        fontSize: 24,
      ),
      text: text,
    );

    // textpainter
    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    /// 자리 잡기
    tp.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );

    // offset
    final offset = Offset(
      (canvasSize - tp.width) * 0.5,
      (canvasSize - tp.height) * 0.5,
    );

    // canvas에 그리기
    tp.paint(canvas, offset);

    // record 중지
    // picture를 리턴함
    return recorder.endRecording();
  }
}

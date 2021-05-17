import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imagePackage;
import 'package:l/l.dart';

import 'text_to_picture_converter.dart';
import 'package:led/models/conversion_result.dart';

class StringToPixelsConverter {
  final String string;
  final double canvasSize;
  final bool border;

  StringToPixelsConverter({
    required this.string,
    required this.canvasSize,
    this.border = false,
  });

  /// convert
  /// make conversion_result
  Future<ToPixelsConversionResult?> convert() async {
    final ui.Picture picture = TextToPictureConverter.convert(
      text: this.string,
      canvasSize: canvasSize,
      border: border,
    );

    late ByteData imageBytes;
    // pixelArray
    late List<List<Color>> pixels;

    try {
      imageBytes = await _pictureToBytes(picture);
      pixels = _bytesToPixelArray(imageBytes);
    } catch (e, st) {
      l.e(e, st);
      return null;
    }

    return ToPixelsConversionResult(
      imageBytes: imageBytes,
      pixels: pixels,
    );
  }

  /// ui.Picture -a-> ByteData
  Future<ByteData> _pictureToBytes(ui.Picture picture) async {
    final ui.Image img =
        await picture.toImage(canvasSize.toInt(), canvasSize.toInt());
    ByteData? bytedata = await img.toByteData(format: ui.ImageByteFormat.png);

    if (bytedata == null) {
      throw ArgumentError('null bytedata not allowed');
    }
    return bytedata;
  }

  // ByteData --> List<List<Color>> (PixelArray)
  List<List<Color>> _bytesToPixelArray(ByteData imageBytes) {
    int y = canvasSize.toInt();
    int x = canvasSize.toInt();

    List<int> values = imageBytes.buffer.asUint8List();
    imagePackage.Image? decodedImage = imagePackage.decodeImage(values);

    if (decodedImage == null) {
      throw ArgumentError('decodedImage is null : not allowed');
    }

    List<List<Color>> pixelArray = List.generate(
      y,
      (_) => List.filled(
        x,
        const Color(0xFFFFFFFF),
      ),
    );

    for (int i = 0; i < y; i++) {
      for (int j = 0; j < x; j++) {
        int pixel = decodedImage.getPixelSafe(i, j);
        int hex = _convertColorSpace(pixel);
        pixelArray[i][j] = Color(hex);
      }
    }
    return pixelArray;
  }

  int _convertColorSpace(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }
}

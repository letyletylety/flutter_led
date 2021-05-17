import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:led/models/conversion_result.dart';

import 'converter/string_to_pixel_converter.dart';
import 'widgets/display_painter.dart';

const canvasSize = 100.0;

class DisplaySimulator extends StatefulWidget {
  final String text;
  final bool border;
  final bool debug;

  const DisplaySimulator({
    Key? key,
    required this.text,
    this.border = false,
    this.debug = false,
  }) : super(key: key);

  @override
  _DisplaySimulatorState createState() => _DisplaySimulatorState();
}

class _DisplaySimulatorState extends State<DisplaySimulator> {
  ByteData? imageBytes;
  List<List<Color>>? pixels;

  @override
  Widget build(BuildContext context) {
    _obtainPixelsFromText(widget.text);

    return Column(
      children: <Widget>[
        SizedBox(height: 96),
        _getDebugPreview(),
        SizedBox(height: 48),
        _getDisplay(),
      ],
    );
  }

  Widget _getDebugPreview() {
    if (imageBytes == null || widget.debug == false) {
      return Container();
    }

    return Image.memory(
      Uint8List.view(imageBytes!.buffer),
      filterQuality: FilterQuality.none,
      width: canvasSize,
      height: canvasSize,
    );
  }

  Widget _getDisplay() {
    if (pixels == null) {
      return Container();
    }

    return CustomPaint(
        size: Size.square(MediaQuery.of(context).size.width),
        painter: DisplayPainter(pixels: pixels, canvasSize: canvasSize));
  }

  // Text에서 Pixels(PixelArray) 를 구함
  void _obtainPixelsFromText(String text) async {
    // Here we will set imageBytes and pixels

    StringToPixelsConverter converter = StringToPixelsConverter(
      string: text,
      border: widget.border,
      canvasSize: canvasSize,
    );

    ToPixelsConversionResult? result;
    result = await converter.convert();

    if (null == result) {
      // null is not allowed
      return;
    }

    setState(() {
      this.imageBytes = result!.imageBytes;
      pixels = result.pixels;
    });
  }
}

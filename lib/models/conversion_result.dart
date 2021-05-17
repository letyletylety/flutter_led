import 'dart:typed_data';

import 'dart:ui';

/// ToPixelsConversionResult
/// imagebytes : ByteData, pixels : List<List<Color>>
class ToPixelsConversionResult {
  ToPixelsConversionResult({
    required this.imageBytes,
    required this.pixels,
  });

  final ByteData imageBytes;
  final List<List<Color>> pixels;
}

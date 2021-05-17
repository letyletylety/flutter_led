import 'package:led/models/conversion_result.dart';

mixin ToPixelsConverter {
  Future<ToPixelsConversionResult> convert();
}

// class ToPixelsConverter {
//   ToPixelsConverter.fromString({
//     required this.string,
//     required this.canvasSize,
//     this.border = false,
//   });

//   ToPixelsConverter.fromCanvas({
//     required this.canvas,
//     required this.canvasSize,
//   });

//   Canvas? canvas;
//   bool? border;
//   String? string;
//   final double canvasSize;

//   Future<ToPixelsConversionResult> convert() async {
//     final ui.Picture picture = TextToPictureConverter.convert(
//       text: this.string,
//       canvasSize: canvasSize,
//       border: border,
//     );
//     final ByteData? imageBytes = await _pictureToBytes(picture);
//     final List<List<Color>> pixels = _bytesToPixelArray(imageBytes);

//     return ToPixelsConversionResult(imageBytes: imageBytes, pixels: pixels);
//   }

//   // picture to bytes
//   Future<ByteData?> _pictureToBytes(ui.Picture picture) async {
//     final ui.Image img = await picture.toImage(
//       canvasSize.toInt(),
//       canvasSize.toInt(),
//     );
//     return await img.toByteData(format: ui.ImageByteFormat.png);
//   }

//   // bytes to pixel array
//   List<List<Color>> _bytesToPixelArray(ByteData imageBytes) {
//     int y = canvasSize.toInt();
//     int x = canvasSize.toInt();

//     List<int> values = imageBytes.buffer.asUint8List();
//     imagePackage.Image? decodedImage = imagePackage.decodeImage(values);
//     List<List<Color>> pixelArray = List.generate(
//       y,
//       (_) => List.generate(
//         x,
//         (_) => Color(0xFFFFFFFF),
//       ),
//     );

//     if (decodedImage == null) {
//       throw ('decodeImage is null');
//     }

//     for (int i = 0; i < y; i++) {
//       for (int j = 0; j < x; j++) {
//         int pixel = decodedImage.getPixelSafe(i, j);
//         int hex = _convertColorSpace(pixel);
//         pixelArray[i][j] = Color(hex);
//       }
//     }

//     return pixelArray;
//   }

//   int _convertColorSpace(int argbColor) {
//     int r = (argbColor >> 16) & 0xFF;
//     int b = argbColor & 0xFF;
//     return (argbColor & 0xFF00FF00) | (b << 16) | r;
//   }
// }

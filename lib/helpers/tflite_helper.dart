import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteHelper {
  static Interpreter? _interpreter;
  static bool _isUint8 = true; // autodetect model type

  static Future<void> loadModel({String model = "assets/model/model.tflite"}) async {
    try {
      _interpreter = await Interpreter.fromAsset(model);
      final inputType = _interpreter!.getInputTensor(0).type;
      _isUint8 = inputType.toString().contains("uint8");
      print("✅ Model loaded successfully ($inputType)");
    } catch (e) {
      print("❌ Failed to load model: $e");
    }
  }

  static Future<List<double>?> classifyImage(String imagePath) async {
    if (_interpreter == null) {
      print("⚠️ Model not loaded!");
      return [];
    }

    try {
      final bytes = File(imagePath).readAsBytesSync();
      final image = img.decodeImage(bytes);
      if (image == null) {
        print("❌ Could not decode image: $imagePath");
        return null;
      }

      const inputSize = 224;
      final resized = img.copyResize(image, width: inputSize, height: inputSize);

      // ✅ Automatically handle float or uint8 input
      final input = List.generate(
        1,
        (_) => List.generate(
          inputSize,
          (y) => List.generate(
            inputSize,
            (x) {
              final pixel = resized.getPixel(x, y);
              if (_isUint8) {
                // For uint8 model
                return [pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt()];
              } else {
                // For float32 model
                return [
                  pixel.r / 255.0,
                  pixel.g / 255.0,
                  pixel.b / 255.0,
                ];
              }
            },
          ),
        ),
      );

      final output = List.filled(2, 0).reshape([1, 2]);
      _interpreter!.run(input, output);

      print("✅ Inference result: $output");
      return (output[0] as List).map((e) => (e as num).toDouble()).toList();
    } catch (e, st) {
      print("❌ Error during inference: $e\n$st");
      return null;
    }
  }

  static void disposeModel() {
    _interpreter?.close();
    print("🧹 Interpreter closed");
  }
}

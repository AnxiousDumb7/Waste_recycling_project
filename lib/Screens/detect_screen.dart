import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// NOTE: image_picker works on mobile. For web the plugin supports file picking as well
// via image_picker_for_web automatically when you add the package.

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File? _imageFile;        // for mobile
  XFile? _xfileForWeb;     // for web (image_picker returns XFile)
  String _result = "No result"; // static result shown
  final ImagePicker _picker = ImagePicker();

  // Static demo detector: randomly picks 'Glass' or 'Paper'
  String _randomDetect() {
    final r = Random().nextBool();
    return r ? "Glass" : "Paper";
  }

  Future<void> _pickImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked == null) return;

      setState(() {
        if (kIsWeb) {
          // For web we store the XFile
          _xfileForWeb = picked;
          _imageFile = null;
        } else {
          _imageFile = File(picked.path);
          _xfileForWeb = null;
        }
        // Static detection: pick random label for demo
        _result = _randomDetect() + " Waste";
      });
    } catch (e) {
      // handle errors
      debugPrint("Image pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (kIsWeb && _xfileForWeb != null) {
      imageWidget = Image.network(_xfileForWeb!.path, height: 220);
    } else if (_imageFile != null) {
      imageWidget = Image.file(_imageFile!, height: 220);
    } else {
      imageWidget = const Icon(Icons.image, size: 120, color: Colors.grey);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Waste Detection")),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Center(child: imageWidget),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload_file),
              label: const Text("Pick Image"),
            ),
            const SizedBox(height: 18),

            // Static detection result area
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text("Result: $_result",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (_result.startsWith("Glass"))
                      const Text("Disposal Tip: Rinse glass and place in green bin.")
                    else if (_result.startsWith("Paper"))
                      const Text("Disposal Tip: Flatten paper and place in blue bin.")
                    else
                      const Text("No tip available.")
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Note: This is a demo static detector. Replace with TFLite model for real detection.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

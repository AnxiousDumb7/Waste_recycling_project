import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/tflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File? _imageFile;
  XFile? _xfileWeb;
  String _result = "No result";
  String _tipTitle = "";
  String _tipDescription = "";
  String _videoLink = "";
  bool _isProcessing = false;
  final ImagePicker picker = ImagePicker();
  Map<String, dynamic>? _tipsData;

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadTipsData();
  }

  Future<void> _loadModel() async {
    try {
      await TFLiteHelper.loadModel();
      debugPrint("Model loaded successfully");
    } catch (e) {
      debugPrint("Error loading model: $e");
    }
  }

  Future<void> _loadTipsData() async {
    try {
      final data = await rootBundle.loadString("assets/data/diy_tips.json");
      setState(() {
        _tipsData = jsonDecode(data);
      });
      debugPrint("✅ Tips JSON loaded successfully");
    } catch (e) {
      debugPrint("❌ Failed to load tips JSON: $e");
    }
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() => _isProcessing = true);

    if (kIsWeb) {
      _xfileWeb = picked;
      _imageFile = null;
    } else {
      _imageFile = File(picked.path);
      _xfileWeb = null;
    }

    await _classifyImage(picked.path);
    setState(() => _isProcessing = false);
  }

  Future<void> _classifyImage(String path) async {
    final result = await TFLiteHelper.classifyImage(path);

    if (result == null || result.isEmpty) {
      setState(() {
        _result = "No result";
        _tipTitle = "";
        _tipDescription = "";
        _videoLink = "";
      });
      return;
    }

    final glassProb = result[0];
    final paperProb = result[1];
    String detectedLabel = glassProb > paperProb ? "glass" : "paper";
    _showRandomTip(detectedLabel);
  }

  void _showRandomTip(String label) {
    if (_tipsData == null || !_tipsData!.containsKey(label)) {
      setState(() {
        _tipTitle = "No tips available";
        _tipDescription = "";
        _videoLink = "";
      });
      return;
    }

    final tipsList = _tipsData![label] as List<dynamic>;
    final randomTip = (tipsList..shuffle()).first;

    setState(() {
      _tipTitle = randomTip["title"];
      _tipDescription = randomTip["description"];
      _videoLink = randomTip["video_link"];
      _result = label == "glass" ? "Glass Detected" : "Paper Detected";
    });
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (kIsWeb && _xfileWeb != null) {
      imageWidget = Image.network(_xfileWeb!.path, height: 220);
    } else if (_imageFile != null) {
      imageWidget = Image.file(_imageFile!, height: 220);
    } else {
      imageWidget = const Icon(Icons.image, size: 120, color: Colors.grey);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Waste Detection"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Center(child: imageWidget),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload),
              label: const Text("Pick Image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
            const SizedBox(height: 25),
            _isProcessing
                ? const CircularProgressIndicator()
                : Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _tipTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _tipDescription,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final Uri uri = Uri.parse(_videoLink);
                              if (await canLaunchUrl(uri)) {
                                final launched = await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                );
                                if (!launched) {
                                  debugPrint(
                                      "⚠️ Fallback: trying browser launch");
                                  await launchUrl(uri,
                                      mode: LaunchMode.platformDefault);
                                }
                              } else {
                                debugPrint(
                                    "❌ Could not launch URL: $_videoLink");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Cannot open YouTube link")),
                                );
                              }
                            },
                            icon: const Icon(Icons.play_circle_fill,
                                color: Colors.red),
                            label: const Text("Watch Video",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

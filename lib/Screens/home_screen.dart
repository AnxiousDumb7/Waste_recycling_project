
import 'package:flutter/material.dart';
import 'detect_screen.dart';
import 'map_screen.dart';
import 'dart:async'; // to wait screen  

class ChangingImageBox extends StatefulWidget {
  const ChangingImageBox({super.key});

  @override
  State<ChangingImageBox> createState() => _ChangingImageBoxState();
}

class _ChangingImageBoxState extends State<ChangingImageBox> {
  final List<String> _images = [
    'assets/images/bins.png',
    'assets/images/h5.png',
    'assets/images/h2.jpeg',
    'assets/images/h3.png',
    'assets/images/h4.png',
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(_images[_currentIndex]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoSort'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 70, 185, 75),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ChangingImageBox(),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              const Text(
                "Classify Waste Smartly",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DetectionScreen()));
                },
                child: const Text('Upload Image'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 16)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MapScreen()));
                },
                child: const Text('Recycle Centers'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16)),
              ),
              const SizedBox(height: 40),
              const Text("Reduce • Reuse • Recycle",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey))
            ],
          ),
        ),
        ), 
      ),
    );
  }
}
class BinsImageBox extends StatelessWidget {
  const BinsImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/bins.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
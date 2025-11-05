import 'package:flutter/material.dart';
import 'detect_screen.dart';
import 'map_screen.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/recycle_logo.png',
                height: 130, // img size 
              ),
              const SizedBox(height: 20),
              const Text(
                "Classify Waste Smartly ",
                style: TextStyle(color: Colors.green, fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const DetectionScreen()));
                },
                child: const Text('Upload Image'),
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MapScreen()));
                },
                child: const Text('Open Map'),
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
              ),
              const SizedBox(height: 40),
              const Text("Reduce • Reuse • Recycle",
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'detect_screen.dart';  // Screen for image detection
import 'map_screen.dart';        // Screen for Google Maps

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar at top
      appBar: AppBar(
        title: const Text("EcoSort"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      // Main body content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
          children: [
            // App title or logo
            const Text(
              "Classify Waste Smartly ♻️",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30), // Space

            // Button to go to Detection Screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Upload Image"),
            ),

            const SizedBox(height: 20), // Space

            // Button to go to Map Screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Open Map"),
            ),

            const SizedBox(height: 40),

            const Text(
              "Reduce • Reuse • Recycle",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

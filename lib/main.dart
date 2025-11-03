import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // Standard Flutter app entry
  runApp(const EcoSortApp());
}

class EcoSortApp extends StatelessWidget {
  const EcoSortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSort',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

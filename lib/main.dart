import 'Screens/welcome_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcoSortApp());
}

class EcoSortApp extends StatelessWidget {
  const EcoSortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, 
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade700,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: WelcomeController(),
    );
  }
}

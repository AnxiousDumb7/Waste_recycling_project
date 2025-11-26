import 'package:flutter/material.dart';
import 'welcome_screen.dart'; 
class WelcomeController extends StatefulWidget {
  const WelcomeController({super.key});

  @override
  State<WelcomeController> createState() => _WelcomeControllerState();
}

class _WelcomeControllerState extends State<WelcomeController>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4), // controls animation speed
      vsync: this,
    );

    _controller.forward(); // starts animation automatically
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated welcome content
          EcoSortWelcomeScreen(animationController: _controller),

    
        ],
      ),
    );
  }
}

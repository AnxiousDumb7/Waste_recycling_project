import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

//particle leaf widget
class LeafParticle extends StatefulWidget {
  final double startX;
  final double size;

  const LeafParticle({super.key, required this.startX, required this.size});
  @override
  State<LeafParticle> createState() => _LeafParticleState();
}

class _LeafParticleState extends State<LeafParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Random random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 6 + Random().nextInt(6)),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -50, end: 900).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          left: widget.startX + sin(_animation.value / 80) * 20,
          top: _animation.value,
          child: Opacity(
            opacity: 0.8,
            child: Icon(
              Icons.eco,
              size: widget.size,
              color: Colors.greenAccent.shade100,
            ),
          ),
        );
      },
    );
  }
}

class EcoSortWelcomeScreen extends StatelessWidget {
  final AnimationController animationController;

  const EcoSortWelcomeScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Dynamic sizing
    final logoSize = size.width * 0.42;
    final titleFont = size.width * 0.1;
    final sloganFont = size.width * 0.055;

    // Smooth Animations
    final imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.7),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );

    final fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/h1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.85),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Floating leaves particles
          ...List.generate(
            8,
            (i) => LeafParticle(
              startX: Random().nextDouble() * size.width,
              size: 16 + Random().nextDouble() * 14,
            ),
          ),

          // MAIN CONTENT
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  SlideTransition(
                    position: imageSlide,
                    child: Container(
                      height: logoSize,
                      width: logoSize,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/images/recycle_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // App Name
                  FadeTransition(
                    opacity: fadeIn,
                    child: Text(
                      "EcoSort",
                      style: GoogleFonts.poppins(
                        fontSize: titleFont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.015),

                  // Slogan
                  FadeTransition(
                    opacity: fadeIn,
                    child: Text(
                      "Sort Smart, Recycle Right,\nSave Earth.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: sloganFont,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Glowing Button
                  FadeTransition(
                    opacity: fadeIn,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent.shade400,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.16,
                          vertical: size.width * 0.044,
                        ),
                        shadowColor: Colors.greenAccent.shade200,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.045,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

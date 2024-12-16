import 'package:flutter/material.dart';
import 'dart:math';

import 'package:github_wrapped/screens/main_screen.dart';

class UsernameInputScreen extends StatefulWidget {
  const UsernameInputScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UsernameInputScreenState createState() => _UsernameInputScreenState();
}

class _UsernameInputScreenState extends State<UsernameInputScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set dark background for the whole screen
      body: Stack(
        children: [
          // Starry Background
          const AnimatedBackground(),

          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your GitHub Username',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'GitHub Username',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final username = _usernameController.text.trim();
                      if (username.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GitHubDataScreen(username: username),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 52, 152, 55), // GitHub green
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Get GitHub Wrapped'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Starry Background Animation
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> stars;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          // Update star positions on every frame
          for (var star in stars) {
            star.updatePosition();
          }
        });
      });
    _controller.repeat(); // Make the animation repeat indefinitely
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    // Create a list of stars uniformly distributed over the screen
    stars = List.generate(100, (index) {
      return Star(screenWidth, screenHeight);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarrySkyPainter(stars),
      size: const Size(double.infinity,
          double.infinity), // Make the size of CustomPaint fill the screen
    );
  }
}

class Star {
  double x;
  double y;
  double speed;
  double size;

  Star(double screenWidth, double screenHeight)
      : x = Random().nextDouble() *
            screenWidth, // Uniformly distribute along width
        y = Random().nextDouble() *
            screenHeight, // Uniformly distribute along height
        speed = Random().nextDouble() * 0.5 + 0.2, // Random speed for each star
        size = Random().nextDouble() * 2 + 1; // Random size for each star

  void updatePosition() {
    x += speed;
    if (x > 400) {
      x = 0; // Reset the star's position when it goes off-screen
    }
    y += speed;
    if (y > 800) {
      y = 0; // Reset the star's position when it goes off-screen
    }
  }
}

class StarrySkyPainter extends CustomPainter {
  final List<Star> stars;

  StarrySkyPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 223, 219, 219).withOpacity(0.6);
    for (var star in stars) {
      canvas.drawCircle(Offset(star.x, star.y), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for animation
  }
}

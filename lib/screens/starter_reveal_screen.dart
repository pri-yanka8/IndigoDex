import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarterRevealScreen extends StatelessWidget {
  final String starterName;
  final String imageUrl;
  final String starterType; // 🔥 New

  const StarterRevealScreen({
    super.key,
    required this.starterName,
    required this.imageUrl,
    required this.starterType,
  });

  @override
  Widget build(BuildContext context) {
    String backgroundImage = switch (starterType.toLowerCase()) {
      "fire" => "assets/images/fire_starter_bg.png",
      "water" => "assets/images/water_starter_bg.png",
      "grass" => "assets/images/grass_starter_bg.png",
      _ => "assets/images/default_bg.png",
    };

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundImage, fit: BoxFit.cover),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(imageUrl, height: 180),
                const SizedBox(height: 7),
                Text(
                  'you chose $starterName!',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed:
                      () => Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Let's goooooo!",
                    style: GoogleFonts.vt323(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

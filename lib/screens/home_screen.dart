import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final String starterImageUrl;

  const HomeScreen({super.key, required this.starterImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'IndigoDex',
                    style: GoogleFonts.pressStart2p(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(starterImageUrl),
                    radius: 22,

                    // backgroundColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _screenCard(
                context,
                title: "Creature Vault",
                bgGradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 233, 35),
                    Color.fromARGB(255, 255, 234, 47),
                    Color.fromARGB(255, 255, 240, 109),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, '/pokemon-list'),
                imagePath: "assets/images/splash_screen_pikachu.png",
              ),
              const SizedBox(height: 20),
              _screenCard(
                context,
                title: "Badge Hall",
                bgGradient: LinearGradient(
                  colors: [
                    Color.fromARGB(197, 31, 102, 209), // Deep royal blue
                    Color.fromARGB(255, 86, 165, 244), // Mid sky blue
                    Color(0xFF64B5F6),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, '/gym-badges'),
                imagePath: "assets/images/sabrina.png",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenCard(
    BuildContext context, {
    required String title,
    required Gradient bgGradient,
    required VoidCallback onTap,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: bgGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.vt323(
                color: const Color.fromARGB(255, 66, 41, 33),
                fontSize: 28,
              ),
            ),
            Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:pokedex/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 255, 251, 124),
              Color.fromARGB(255, 241, 222, 45),
            ],
            radius: 1.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_screen_pikachu.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "Hey there, Trainer!",
                style: GoogleFonts.vt323(
                  fontSize: 20,
                  color: Color(0xFF4E342E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

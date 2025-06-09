import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex/auth/auth_service.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/setup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final user = await AuthService().signInWithGoogle();

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google Sign-In failed')));
      return;
    }

    final email = user.email;

    // 🔍 Check if user already exists in Firestore
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      // ✅ User exists → Go to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // 🆕 New user → Go to SetupScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SetupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 255, 252, 165),
                Color.fromARGB(255, 255, 236, 61),
              ],
              center: Alignment.bottomCenter,
              radius: 1.2,
            ),
          ),
          child: Column(
            children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Image.asset(
                  'assets/images/welcome_screen.jpg',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.55,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'JhotoDex',
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    onPressed: () {
                      // TODO: Guest user flow
                    },
                    child: const Text(
                      "Guest User",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              const Text("or"),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => _handleGoogleSignIn(context),
                    child: const Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 60,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

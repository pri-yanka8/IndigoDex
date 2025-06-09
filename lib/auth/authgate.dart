import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/welcome_screen.dart';
// import 'home_screen.dart';
// import 'welcome_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const HomeScreen();
    } else {
      return const WelcomeScreen();
    }
  }
}

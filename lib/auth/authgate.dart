import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/welcome_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const WelcomeScreen();
    }

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const WelcomeScreen(); // fallback
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final starterImageUrl = data['pokemonImage'] as String?;

        if (starterImageUrl == null || starterImageUrl.isEmpty) {
          return const WelcomeScreen(); // fallback if data is incomplete
        }

        return HomeScreen(starterImageUrl: starterImageUrl);
      },
    );
  }
}

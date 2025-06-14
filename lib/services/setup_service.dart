import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/screens/starter_reveal_screen.dart';
// import '../providers/user_provider.dart';

class SetupService {
  static final Map<String, List<String>> starterPool = {
    'Fire': ['Charmander', 'Vulpix', 'Growlithe'],
    'Water': ['Squirtle', 'Psyduck', 'Poliwag'],
    'Grass': ['Bulbasaur', 'Oddish', 'Bellsprout'],
  };
  static Future<bool> isUsernameTaken(String username) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username.trim())
      .limit(1)
      .get();

  return snapshot.docs.isNotEmpty;
}

  static Future<void> handleContinueLogic({
    required BuildContext context,
    required String? selectedType,
    required String backgroundImage,
    required String username,
  }) async {
    if (selectedType == null || username.trim().isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    final selectedList = starterPool[selectedType]!;
    final assignedPokemon = selectedList[Random().nextInt(selectedList.length)];

    // ✅ Step: Fetch Pokémon ID from species API
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon/$assignedPokemon"),
    );
    final data = jsonDecode(response.body);
    final id = data['id'];

    final imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username.trim(),
        'starterPokemon': assignedPokemon,
        'pokemonImage': imageUrl,
        'email': user!.email,
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (_, __, ___) => StarterRevealScreen(
                starterName: assignedPokemon,
                imageUrl: imageUrl,
                starterType: selectedType,
              ),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    }
  }
}

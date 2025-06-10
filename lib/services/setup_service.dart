import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../providers/user_provider.dart';

class SetupService {
  static final Map<String, List<String>> starterPool = {
    'Fire': ['Cyndaquil', 'Slugma', 'Houndour'],
    'Water': ['Totodile', 'Wooper', 'Remoraid'],
    'Grass': ['Chikorita', 'Hoppip', 'Bellsprout'],
  };

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
    final imagePath = "assets/images/${assignedPokemon.toLowerCase()}.png";

    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username.trim(),
        'starterPokemon': assignedPokemon,
        'pokemonImage': imagePath,
        'email': user!.email,
      });

      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}

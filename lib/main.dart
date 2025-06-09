import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex/auth/authgate.dart';
// import 'package:pokedex/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Johto Pokédex',
      home: const AuthGate(),
    );
  }
}

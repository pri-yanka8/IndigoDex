import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex/auth/authgate.dart';
import 'package:pokedex/providers/user_provider.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/splash_screen.dart';
import 'package:pokedex/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
// import 'package:pokedex/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Johto Pokédex',
      home: const SplashScreen(),
    );
  }
}

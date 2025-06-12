import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
// import 'package:pokedex/auth/authgate.dart';
import 'package:pokedex/providers/user_provider.dart';
import 'package:pokedex/screens/badgehall_screen.dart';
import 'package:pokedex/screens/creaturevault_screen.dart';
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
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
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
        '/home': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return HomeScreen(starterImageUrl: args['starterImageUrl']);
        },
        '/gym-badges': (context) => const BadgeHallScreen(),
        '/pokemon-list': (context) => const CreatureVaultScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'indigo Pokédex',
      home: const SplashScreen(),
    );
  }
}

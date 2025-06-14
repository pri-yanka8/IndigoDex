import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/providers/pokemon_provider.dart';

class CreatureVaultScreen extends StatefulWidget {
  const CreatureVaultScreen({super.key});

  @override
  State<CreatureVaultScreen> createState() => _CreatureVaultScreenState();
}

class _CreatureVaultScreenState extends State<CreatureVaultScreen> {
  LinearGradient getTypeGradient(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const LinearGradient(
          colors: [Color(0xFFFFA07A), Color.fromARGB(255, 255, 219, 166)],
        ); // salmon → peach
      case 'water':
        return const LinearGradient(
          colors: [Color(0xFF81D4FA), Color.fromARGB(255, 212, 241, 255)],
        ); // sky blue → pale blue
      case 'grass':
        return const LinearGradient(
          colors: [Color(0xFFA5D6A7), Color.fromARGB(255, 222, 255, 225)],
        ); // medium green → mint
      case 'electric':
        return const LinearGradient(
          colors: [Color(0xFFFFF176), Color(0xFFFFF9C4)],
        ); // yellow → lemon
      case 'rock':
        return const LinearGradient(
          colors: [Color(0xFFD7CCC8), Color.fromARGB(255, 255, 241, 227)],
        ); // light brown → stone
      case 'psychic':
        return const LinearGradient(
          colors: [Color(0xFFF48FB1), Color.fromARGB(255, 255, 214, 228)],
        ); // rose → blush
      case 'poison':
        return const LinearGradient(
          colors: [Color(0xFFCE93D8), Color.fromARGB(255, 249, 213, 255)],
        ); // lavender → pastel
      case 'ground':
        return const LinearGradient(
          colors: [Color(0xFFBCAAA4), Color.fromARGB(255, 244, 205, 192)],
        ); // warm tan → off-white
      case 'ice':
        return const LinearGradient(
          colors: [Color(0xFFB3E5FC), Color.fromARGB(255, 205, 249, 255)],
        ); 
      case 'bug':
        return const LinearGradient(
          colors: [Color(0xFFC5E1A5), Color.fromARGB(255, 232, 255, 205)],
        ); 
      case 'normal':
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 178, 178, 178),
            Color.fromARGB(255, 221, 221, 221),
          ],
        ); // gray → white
      case 'ghost':
        return const LinearGradient(
          colors: [Color(0xFFB39DDB), Color.fromARGB(255, 233, 218, 255)],
        ); 
      default:
        return const LinearGradient(colors: [Colors.grey, Colors.white]);
    }
  }

  String getTypeEmoji(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return '🔥';
      case 'water':
        return '💧';
      case 'grass':
        return '🌿';
      case 'electric':
        return '⚡';
      case 'rock':
        return '🪨';
      case 'psychic':
        return '🔮';
      case 'poison':
        return '☠️';
      case 'ground':
        return '🌍';
      case 'ice':
        return '❄️';
      case 'ghost':
        return '👻';
      case 'bug':
        return '🐛';
      case 'dragon':
        return '🐲';
      case 'normal':
        return '⭐';
      default:
        return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemonList = pokemonProvider.pokemonList;
    final isLoading = pokemonProvider.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, size: 30),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Creature Vault",
                            style: GoogleFonts.pressStart2p(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Pokémon List
                    Expanded(
                      child: ListView.builder(
                        itemCount: pokemonList.length,
                        itemBuilder: (context, index) {
                          final pokemon = pokemonList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: getTypeGradient(pokemon['type']),
                              ),

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                height: 110,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            pokemon['name']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.pressStart2p(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${pokemon['type'].toString()} ${getTypeEmoji(pokemon['type'])}',
                                            style: GoogleFonts.vt323(
                                              fontSize: 18,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // 👉 Right Side (Image)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        pokemon['image'],
                                        height: 100, // Adjust as needed
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

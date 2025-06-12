import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatureVaultScreen extends StatefulWidget {
  const CreatureVaultScreen({super.key});

  @override
  State<CreatureVaultScreen> createState() => _CreatureVaultScreenState();
}

class _CreatureVaultScreenState extends State<CreatureVaultScreen> {
  List<Map<String, dynamic>> _pokemonList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKantoPokemon();
  }

  Future<void> fetchKantoPokemon() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokedex/2'); // Kanto
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final entries = data['pokemon_entries'];

      List<Map<String, dynamic>> loadedPokemon = [];

      for (var entry in entries) {
        final speciesUrl = entry['pokemon_species']['url'];
        final id = entry['entry_number'];

        final detailUrl = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');
        final detailResponse = await http.get(detailUrl);
        if (detailResponse.statusCode == 200) {
          final detailData = jsonDecode(detailResponse.body);
          final name = detailData['name'];
          final type = detailData['types'][0]['type']['name'];
          final image =
              detailData['sprites']['other']['official-artwork']['front_default'];

          loadedPokemon.add({'name': name, 'type': type, 'image': image});
        }
      }

      setState(() {
        _pokemonList = loadedPokemon;
        _isLoading = false;
      });
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
      case 'normal':
        return '⭐';
      default:
        return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Creature Vault",
                            style: GoogleFonts.pressStart2p(
                              fontSize: 19,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🃏 Pokémon List
                    Expanded(
                      child: ListView.builder(
                        itemCount: _pokemonList.length,
                        itemBuilder: (context, index) {
                          final pokemon = _pokemonList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.amber.shade100,
                                    Colors.amber.shade200,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                title: Text(
                                  pokemon['name'].toString().toUpperCase(),
                                  style: GoogleFonts.vt323(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  '${getTypeEmoji(pokemon['type'])} ${pokemon['type'].toString().toUpperCase()}',
                                  style: GoogleFonts.vt323(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                trailing: Image.network(
                                  pokemon['image'],
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () {
                                  // TODO: Navigate to detail screen
                                },
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

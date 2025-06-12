import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonProvider with ChangeNotifier {
  List<Map<String, dynamic>> _pokemonList = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get pokemonList => _pokemonList;
  bool get isLoading => _isLoading;

  PokemonProvider() {
    fetchKantoPokemon();
  }

  Future<void> fetchKantoPokemon() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokedex/2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final entries = data['pokemon_entries'];
      print("corrcect");

      // Parallel fetching with Future.wait
      final List<Future<Map<String, dynamic>?>> requests =
          entries.map<Future<Map<String, dynamic>?>>((entry) async {
            final id = entry['entry_number'];
            final detailUrl = Uri.parse(
              'https://pokeapi.co/api/v2/pokemon/$id',
            );
            final detailResponse = await http.get(detailUrl);

            if (detailResponse.statusCode == 200) {
              final detailData = jsonDecode(detailResponse.body);
              final name = detailData['name'];
              final type = detailData['types'][0]['type']['name'];
              final image =
                  detailData['sprites']['other']['official-artwork']['front_default'];

              return {'name': name, 'type': type, 'image': image};
            }
            return null;
          }).toList();

      final results = await Future.wait(requests);

      _pokemonList = results.whereType<Map<String, dynamic>>().toList();
      _isLoading = false;
      notifyListeners();
    }
  }
}

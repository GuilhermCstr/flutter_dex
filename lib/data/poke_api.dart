import 'dart:convert';

import 'package:flutter_dex/data/pokemon.dart';
import 'package:http/http.dart' as http;

class PokeApi {
  static const String url = 'https://pokeapi.co/api/v2/';

  Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get(
      Uri.parse('$url/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final int genderRate = await fetchGenderRate(id);
      json['genderRate'] = genderRate;

      final String description = await fetchDescription(id);
      json['description'] = description;
      return Pokemon.fromJson(json);
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<int> fetchGenderRate(String id) async {
    final response = await http.get(Uri.parse('$url/pokemon-species/$id'));
    return jsonDecode(response.body)['gender_rate'];
  }

  Future<String> fetchDescription(String id) async {
    final response = await http.get(Uri.parse('$url/pokemon-species/$id'));
    final Map<String, dynamic> json = jsonDecode(response.body)['flavor_text_entries']
        .firstWhere((element) => element['language']['name'] == 'en');
    return json['flavor_text'];
  }

  Future<List<String>> fetchFilterPokemon(String? filter) async {
    final response = await http.get(Uri.parse('$url/pokemon?limit=1025'));
    final Map<String, dynamic> json = jsonDecode(response.body);

    final List<dynamic> results = json['results'];

    if (filter == null || filter.isEmpty) {
      return results
          .where((pokemon) =>
              pokemon is Map && pokemon.containsKey('name') && pokemon['name'] is String)
          .map((pokemon) => pokemon['name'] as String)
          .toList();
    } else {
      if (int.tryParse(filter) != null) {
        return results
            .where((pokemon) =>
                pokemon is Map &&
                pokemon.containsKey('url') &&
                (pokemon['url'] as String).endsWith('/$filter/'))
            .map((pokemon) => pokemon['name'] as String)
            .toList();
      }
      return results
          .where((pokemon) =>
              pokemon is Map &&
              pokemon.containsKey('name') &&
              pokemon['name'] is String &&
              (pokemon['name'] as String).toLowerCase().contains(filter.toLowerCase()))
          .map((pokemon) => pokemon['name'] as String)
          .toList();
    }
  }
}

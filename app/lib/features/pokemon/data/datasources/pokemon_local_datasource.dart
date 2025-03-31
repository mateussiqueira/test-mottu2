import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/pokemon_entity.dart';

class PokemonLocalDataSource {
  final SharedPreferences prefs;
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';

  PokemonLocalDataSource(this.prefs);

  Future<List<PokemonEntityImpl>> getPokemonList() async {
    final jsonString = prefs.getString(_pokemonListKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => PokemonEntityImpl.fromJson(json)).toList();
  }

  Future<void> savePokemonList(List<PokemonEntityImpl> pokemons) async {
    final jsonList = pokemons.map((pokemon) => pokemon.toJson()).toList();
    await prefs.setString(_pokemonListKey, json.encode(jsonList));
  }

  Future<PokemonEntityImpl?> getPokemonDetail(int id) async {
    final jsonString = prefs.getString('$_pokemonDetailKey$id');
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);
    return PokemonEntityImpl.fromJson(json);
  }

  Future<void> savePokemonDetail(PokemonEntityImpl pokemon) async {
    final json = pokemon.toJson();
    await prefs.setString('$_pokemonDetailKey${pokemon.id}', jsonEncode(json));
  }
}

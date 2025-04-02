import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/entities/pokemon_factory.dart';
import 'i_pokemon_local_datasource.dart';

class PokemonLocalDataSource implements IPokemonLocalDataSource {
  final SharedPreferences prefs;
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailKey = 'pokemon_detail_';

  PokemonLocalDataSource(this.prefs);

  @override
  Future<List<IPokemonEntity>> getPokemonList() async {
    final jsonString = prefs.getString(_pokemonListKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => PokemonFactory.fromJson(json)).toList();
  }

  @override
  Future<void> savePokemonList(List<IPokemonEntity> pokemons) async {
    final jsonList = pokemons.map((pokemon) => pokemon.toJson()).toList();
    await prefs.setString(_pokemonListKey, json.encode(jsonList));
  }

  @override
  Future<IPokemonEntity?> getPokemonDetail(int id) async {
    final jsonString = prefs.getString('$_pokemonDetailKey$id');
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);
    return PokemonFactory.fromJson(json);
  }

  @override
  Future<void> savePokemonDetail(IPokemonEntity pokemon) async {
    final json = pokemon.toJson();
    await prefs.setString('$_pokemonDetailKey${pokemon.id}', jsonEncode(json));
  }
}

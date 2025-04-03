import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_list/features/pokemon_list/domain/entities/pokemon_entity.dart';
import 'package:pokemon_list/features/pokemon_list/domain/entities/type_relations.dart';

class TypeService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<TypeRelations> getTypeRelations(String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/type/$type'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final damageRelations = data['damage_relations'];

        return TypeRelations.fromJson(damageRelations);
      } else {
        throw Exception('Failed to load type relations');
      }
    } catch (e) {
      throw Exception('Error fetching type relations: $e');
    }
  }

  Future<void> loadTypeRelationsForPokemon(PokemonEntity pokemon) async {
    for (final type in pokemon.types) {
      try {
        final relations = await getTypeRelations(type);
        pokemon.typeRelations.value = relations;
        break; // Load relations for the first type only
      } catch (e) {
        print('Error loading relations for type $type: $e');
      }
    }
  }
}

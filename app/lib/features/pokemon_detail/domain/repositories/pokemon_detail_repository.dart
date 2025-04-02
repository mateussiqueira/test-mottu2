import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';

abstract class PokemonDetailRepository {
  Future<PokemonEntity> getPokemonById(int id);
  Future<List<PokemonEntity>> getPokemonsByType(String type);
  Future<List<PokemonEntity>> getPokemonsByAbility(String ability);
}

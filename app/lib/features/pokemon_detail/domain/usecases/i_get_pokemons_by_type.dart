import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class IGetPokemonsByType {
  Future<List<PokemonEntity>> call(String type);
}

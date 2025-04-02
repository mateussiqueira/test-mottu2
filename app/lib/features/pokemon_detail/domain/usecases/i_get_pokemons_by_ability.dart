import '../../../pokemon/domain/entities/pokemon_entity.dart';

abstract class IGetPokemonsByAbility {
  Future<List<PokemonEntity>> call(String ability);
}

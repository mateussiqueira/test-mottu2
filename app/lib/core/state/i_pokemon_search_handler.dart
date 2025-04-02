import '../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokemonSearchHandler {
  List<IPokemonEntity> filterPokemons(
      List<IPokemonEntity> pokemons, String query);
}

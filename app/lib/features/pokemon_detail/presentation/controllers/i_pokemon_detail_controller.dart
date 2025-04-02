import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonDetailController {
  PokemonEntity get pokemon;
  bool get isLoading;
  String? get error;
  List<PokemonEntity> get sameTypePokemons;
  List<PokemonEntity> get sameAbilityPokemons;

  Future<void> fetchPokemonById(int id);
  Future<void> fetchPokemonsByType(String type);
  Future<void> fetchPokemonsByAbility(String ability);
  void clearError();
}

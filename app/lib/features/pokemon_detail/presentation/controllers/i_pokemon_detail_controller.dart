import 'package:get/get.dart';

import '../../../../core/state/i_base_state_controller.dart';
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';

/// Interface for Pokemon detail controller
abstract class IPokemonDetailController extends IBaseStateController {
  /// The current Pokemon being displayed
  IPokemonEntity? get pokemon;

  /// Sets the current Pokemon and loads related Pokemon
  void setPokemon(IPokemonEntity pokemon);

  /// List of Pokemon with the same type as the current Pokemon
  RxList<IPokemonEntity> get sameTypePokemons;

  /// List of Pokemon with the same ability as the current Pokemon
  RxList<IPokemonEntity> get sameAbilityPokemons;

  /// Fetches Pokemon with the given type
  Future<void> fetchPokemonsByType(String type);

  /// Fetches Pokemon with the given ability
  Future<void> fetchPokemonsByAbility(String ability);

  /// Navigates to a page showing related Pokemon
  void navigateToRelatedPokemons(List<IPokemonEntity> pokemons, String title);
}

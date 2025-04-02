import '../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'app_status.dart';

abstract class IPokemonStateManager {
  AppStatus get status;
  List<IPokemonEntity> get pokemons;
  List<IPokemonEntity> get filteredPokemons;
  String get searchQuery;
  String? get error;

  void updatePokemons(List<IPokemonEntity> newPokemons);
  void updateSearchQuery(String query);
  void setError(String? errorMessage);
  void setStatus(AppStatus newStatus);
  Future<void> initialize();
}

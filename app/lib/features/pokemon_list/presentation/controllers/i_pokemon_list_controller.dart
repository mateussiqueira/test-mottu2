import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonListController {
  List<PokemonEntity> get pokemons;
  bool get isLoading;
  String? get error;
  bool get hasMore;
  int get currentPage;
  String get searchQuery;

  Future<void> fetchPokemonList();
  Future<void> loadMorePokemons();
  Future<void> search(String query);
  void clearSearch();
  void clearError();
}

import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/pokemon_list_state.dart';

/// Interface for PokemonListController
abstract class IPokemonListController extends GetxController {
  /// List of Pokemon
  RxList<PokemonEntity> get pokemons;

  /// Whether more Pokemon are being loaded
  bool get isLoadingMore;

  /// Current page number
  int get currentPage;

  /// Whether there are more Pokemon to load
  bool get hasMore;

  /// Current search query
  String get searchQuery;

  /// Current filter type
  String get filterType;

  /// Current filter ability
  String get filterAbility;

  /// State of the controller
  PokemonListState get state;

  /// Whether there is an error
  bool get hasError;

  /// Error message
  @override
  String? get error;

  /// Fetches the initial list of Pokemon
  Future<void> fetchPokemonList();

  /// Loads more Pokemon
  Future<void> loadMore();

  /// Searches for Pokemon
  void search(String query);

  /// Filters Pokemon by type
  Future<void> filterByType(String type);

  /// Filters Pokemon by ability
  Future<void> filterByAbility(String ability);

  /// Clears all filters
  void clearFilters();

  /// Clears the search query
  void clearSearch();

  /// Navigates to the Pokemon detail page
  void navigateToDetail(PokemonEntity pokemon);
}

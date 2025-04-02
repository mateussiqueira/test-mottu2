import 'package:get/get.dart';

import '../../../../core/state/i_base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokemonListController extends IBaseStateController {
  RxList<IPokemonEntity> get pokemons;
  bool get isLoadingMore;
  @override
  String? get error;
  int get currentPage;
  bool get hasMore;
  String get searchQuery;
  String get filterType;
  String get filterAbility;

  Future<void> fetchPokemonList();
  Future<void> loadMorePokemons();
  Future<void> search(String query);
  Future<void> loadPokemonsByType(String type);
  Future<void> loadPokemonsByAbility(String ability);
  void clearFilters();
  void clearSearch();
  void navigateToDetail(IPokemonEntity pokemon);
}

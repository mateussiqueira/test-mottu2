import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonSearchController {
  RxList<PokemonEntity> get searchResults;
  RxBool get isLoading;
  String? get error;
  RxString get lastQuery;

  Future<void> search(String query);
  void clearSearch();
  void navigateToDetail(PokemonEntity pokemon);
}

import 'package:get/get.dart';

import '../../../../core/state/i_base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

abstract class IPokemonSearchController extends IBaseStateController {
  RxList<IPokemonEntity> get searchResults;
  Future<void> search(String query);
  void clearSearch();
  void navigateToDetail(IPokemonEntity pokemon);
}

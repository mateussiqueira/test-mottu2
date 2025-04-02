import 'package:get/get.dart';

import '../../../../core/domain/result.dart' as core;
import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/usecases/i_get_pokemon_detail.dart';

class PokemonDetailController extends GetxController {
  final IGetPokemonDetail _getPokemonDetail;

  PokemonDetailController(this._getPokemonDetail);

  final Rx<IPokemonEntity?> _pokemon = Rx<IPokemonEntity?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  IPokemonEntity? get pokemon => _pokemon.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    final pokemon = Get.arguments as IPokemonEntity?;
    if (pokemon != null) {
      _pokemon.value = pokemon;
    } else {
      _error.value = 'Pokemon not found';
    }
  }

  Future<void> fetchPokemonDetail(int id) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final core.Result<IPokemonEntity> result =
          await _getPokemonDetail.call(id);

      if (result.isSuccess && result.data != null) {
        _pokemon.value = result.data;
      } else {
        _error.value = result.error ?? 'Unknown error';
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    if (_pokemon.value != null) {
      await fetchPokemonDetail(_pokemon.value!.id);
    }
  }
}

import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail_usecase.dart';

/// Implementation of the GetPokemonDetail use case
class GetPokemonDetailUseCase implements IGetPokemonDetailUseCase {
  final IPokemonRepository _repository;

  GetPokemonDetailUseCase(this._repository);

  @override
  Future<core.Result<IPokemonEntity>> call(int id) async {
    try {
      return await _repository.getPokemonDetail(id);
    } catch (e) {
      return core.Result.failure(
          'Failed to get Pokemon details: ${e.toString()}');
    }
  }

  @override
  String toString() {
    return 'GetPokemonDetailUseCase()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetPokemonDetailUseCase && other._repository == _repository;
  }

  @override
  int get hashCode => _repository.hashCode;
}

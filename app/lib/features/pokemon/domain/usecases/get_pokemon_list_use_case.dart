import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list_use_case.dart';

/// Implementation of the GetPokemonList use case
class GetPokemonListUseCase implements IGetPokemonListUseCase {
  final IPokemonRepository _repository;

  GetPokemonListUseCase(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call({
    required int limit,
    required int offset,
  }) async {
    try {
      return await _repository.getPokemonList(
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      return core.Result.failure('Failed to get Pokemon list: ${e.toString()}');
    }
  }

  @override
  String toString() {
    return 'GetPokemonListUseCase()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetPokemonListUseCase && other._repository == _repository;
  }

  @override
  int get hashCode => _repository.hashCode;
}

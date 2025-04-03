import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list_usecase.dart';

/// Implementation of the GetPokemonList use case
class GetPokemonListUseCase implements IGetPokemonListUseCase {
  final IPokemonRepository _repository;

  GetPokemonListUseCase(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call({int? limit, int? offset}) async {
    try {
      final result =
          await _repository.getPokemonList(limit: limit, offset: offset);
      return result;
    } catch (e) {
      return Result.failure(
          Failure(message: 'Failed to get Pokemon list: ${e.toString()}'));
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

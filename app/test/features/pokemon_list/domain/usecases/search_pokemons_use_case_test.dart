import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/domain/usecases/search_pokemons_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PokemonRepository])
import 'search_pokemons_use_case_test.mocks.dart';

void main() {
  late SearchPokemonsUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = SearchPokemonsUseCase(mockRepository);
  });

  final tPokemons = [
    PokemonEntityImpl(
      id: 1,
      name: 'bulbasaur',
      imageUrl: 'https://example.com/bulbasaur.png',
      types: ['grass', 'poison'],
      abilities: ['overgrow', 'chlorophyll'],
      height: 7,
      weight: 69,
      baseExperience: 64,
    ),
  ];

  test(
    'should search pokemons from the repository',
    () async {
      // arrange
      const tQuery = 'bulba';
      when(mockRepository.searchPokemon(tQuery))
          .thenAnswer((_) async => Result.success(tPokemons));

      // act
      final result = await useCase(tQuery);

      // assert
      expect(result.isSuccess, true);
      expect(result.data, equals(tPokemons));
      verify(mockRepository.searchPokemon(tQuery));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

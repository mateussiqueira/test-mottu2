import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:mobile/features/pokemon_list/domain/usecases/get_pokemons_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemons_use_case_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemonsUseCase useCase;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    useCase = GetPokemonsUseCase(mockRepository);
  });

  final tPokemons = [
    PokemonEntityImpl(
      id: 1,
      name: 'Bulbasaur',
      imageUrl: 'https://example.com/bulbasaur.png',
      types: ['grass', 'poison'],
      abilities: ['overgrow'],
      height: 7,
      weight: 69,
      baseExperience: 64,
    ),
  ];

  test(
    'should get pokemons from the repository',
    () async {
      // arrange
      when(mockRepository.getPokemonList(offset: 0, limit: 20))
          .thenAnswer((_) async => Result.success(tPokemons));

      // act
      final result = await useCase();

      // assert
      expect(result.isSuccess, true);
      result.fold(
        (error) => fail('Should not return error'),
        (data) => expect(data, tPokemons),
      );
      verify(mockRepository.getPokemonList(offset: 0, limit: 20));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

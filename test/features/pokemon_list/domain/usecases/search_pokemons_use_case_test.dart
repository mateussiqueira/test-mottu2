import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:pokeapi/features/pokemon_list/domain/usecases/search_pokemons_use_case.dart';

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
    const Pokemon(
      id: 1,
      name: 'Bulbasaur',
      imageUrl: 'https://example.com/bulbasaur.png',
      types: ['grass', 'poison'],
      stats: [
        {'name': 'hp', 'value': 45},
        {'name': 'attack', 'value': 49},
      ],
      abilities: ['overgrow'],
      moves: ['tackle', 'growl'],
      evolutionChain: [],
      locations: [],
      height: 0.7,
      weight: 6.9,
    ),
  ];

  test(
    'should search pokemons from the repository',
    () async {
      // arrange
      const tQuery = 'bulba';
      when(mockRepository.searchPokemons(tQuery))
          .thenAnswer((_) async => tPokemons);

      // act
      final result = await useCase(tQuery);

      // assert
      expect(result, equals(tPokemons));
      verify(mockRepository.searchPokemons(tQuery));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}

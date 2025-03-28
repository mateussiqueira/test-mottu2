import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_bloc.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_event.dart';
import 'package:pokeapi/features/pokemon_detail/presentation/bloc/pokemon_detail_state.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:pokeapi/features/pokemon_list/domain/repositories/pokemon_repository.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late PokemonDetailBloc bloc;
  late MockPokemonRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    bloc = PokemonDetailBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('PokemonDetailBloc', () {
    final pokemon = Pokemon(
      id: '1',
      name: 'bulbasaur',
      imageUrl: 'https://example.com/bulbasaur.png',
      types: ['grass', 'poison'],
      abilities: ['overgrow', 'chlorophyll'],
      stats: {'hp': 45, 'attack': 49, 'defense': 49},
      height: 0.7,
      weight: 6.9,
      evolutionChain: ['bulbasaur', 'ivysaur', 'venusaur'],
      locations: ['pallet-town', 'viridian-city'],
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [PokemonDetailLoading, PokemonDetailLoaded] when LoadPokemonDetail is successful',
      build: () {
        when(mockRepository.getPokemonById('1'))
            .thenAnswer((_) async => pokemon);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonDetail('1')),
      expect: () => [
        PokemonDetailLoading(),
        PokemonDetailLoaded(pokemon),
      ],
      verify: (bloc) => mockRepository.getPokemonById('1'),
    );

    blocTest<PokemonDetailBloc, PokemonDetailState>(
      'should emit [PokemonDetailLoading, PokemonDetailError] when LoadPokemonDetail fails',
      build: () {
        when(mockRepository.getPokemonById('1'))
            .thenThrow(Exception('Failed to load pokemon'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPokemonDetail('1')),
      expect: () => [
        PokemonDetailLoading(),
        PokemonDetailError('Failed to load pokemon'),
      ],
      verify: (bloc) => mockRepository.getPokemonById('1'),
    );
  });
}

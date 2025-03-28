import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/adapters/poke_api_adapter.dart';
import '../../../core/data/repositories/pokemon_repository_impl.dart';
import '../../../core/domain/entities/pokemon.dart';
import '../../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import '../../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../../features/related_pokemons/presentation/bloc/related_pokemons_bloc.dart'
    as related;
import '../../../features/related_pokemons/presentation/pages/related_pokemons_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final repository = PokemonRepositoryImpl(PokeApiAdapter());
              return PokemonListBloc(repository: repository)
                ..add(const LoadPokemons());
            },
            child: const PokemonListPage(),
          ),
        );

      case '/pokemon-detail':
        final pokemon = settings.arguments as Pokemon;
        return MaterialPageRoute(
          builder: (_) => PokemonDetailPage(pokemon: pokemon),
        );

      case '/related-pokemons':
        final args = settings.arguments as Map<String, dynamic>;
        final type = args['type'] as String?;
        final ability = args['ability'] as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final repository = PokemonRepositoryImpl(PokeApiAdapter());
              final bloc = related.RelatedPokemonsBloc(repository: repository);
              if (type != null) {
                bloc.add(related.LoadPokemonsByType(type));
              } else if (ability != null) {
                bloc.add(related.LoadPokemonsByAbility(ability));
              }
              return bloc;
            },
            child: const RelatedPokemonsPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'data/repositories/pokemon_repository.dart';
import 'presentation/blocs/pokemon_bloc.dart';
import 'presentation/pages/pokemon_list_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PokemonBloc(locator<PokemonRepository>()),
        child: const PokemonListPage(),
      ),
    );
  }
}

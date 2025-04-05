import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/domain/entities/pokemon.dart';
import '../widgets/pokemon_image.dart';
import '../widgets/pokemon_info.dart';
import '../widgets/pokemon_stats.dart';
import '../widgets/pokemon_types.dart';
import '../widgets/pokemon_abilities.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late Pokemon pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = Get.arguments as Pokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PokemonImage(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonInfo(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonTypes(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonAbilities(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonStats(pokemon: pokemon),
          ],
        ),
      ),
    );
  }
}
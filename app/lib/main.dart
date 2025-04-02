import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/di.dart';
import 'core/presentation/routes/app_router.dart';
import 'features/pokemon_detail/domain/usecases/get_pokemon_by_id.dart';
import 'features/pokemon_detail/domain/usecases/get_pokemons_by_ability.dart';
import 'features/pokemon_detail/domain/usecases/get_pokemons_by_type.dart';
import 'features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);

  // Setup dependencies
  await setupDependencies();

  // Register controllers
  Get.lazyPut(
    () => PokemonDetailController(
      getPokemonById: getIt<GetPokemonById>(),
      getPokemonsByType: getIt<GetPokemonsByType>(),
      getPokemonsByAbility: getIt<GetPokemonsByAbility>(),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PokeAPI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
      defaultTransition: Transition.fade,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'core/presentation/widgets/connectivity_wrapper.dart';
import 'core/services/cache_service.dart';
import 'data/repositories/pokemon_repository.dart';
import 'presentation/blocs/pokemon_bloc.dart';
import 'presentation/pages/pokemon_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase (apenas se não estiver em modo web ou se tiver configuração)
  try {
    await Firebase.initializeApp();
    
    // Configurar Firebase Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {
    // Ignorar erros de inicialização do Firebase
    debugPrint('Firebase não inicializado: $e');
  }
  
  setupLocator();
  
  // Inicializar o CacheService e configurar limpeza de cache ao fechar o app
  final prefs = await SharedPreferences.getInstance();
  final cacheService = CacheService(preferences: prefs);
  Get.put(cacheService);
  await cacheService.setupCacheClearOnAppClose();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.pokemonList,
      getPages: locator<AppRouter>().routes,
      defaultTransition: Transition.cupertino,
      home: ConnectivityWrapper(
        child: BlocProvider(
          create: (context) => PokemonBloc(locator<PokemonRepository>()),
          child: const PokemonListPage(),
        ),
      ),
    );
  }
}

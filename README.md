# PokeAPI Flutter App

A Flutter application that displays information about Pokémon using the PokeAPI.

## Features

- List of Pokémon with pagination
- Search Pokémon by name
- View detailed information about each Pokémon
- Filter Pokémon by type and ability
- Caching for offline access
- Clean Architecture implementation

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── data/
│   │   ├── adapters/
│   │   │   └── poke_api_adapter.dart
│   │   ├── models/
│   │   │   └── pokemon_model.dart
│   │   └── repositories/
│   │       └── pokemon_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── pokemon.dart
│   │   └── repositories/
│   │       └── pokemon_repository.dart
│   └── services/
│       └── http_client.dart
├── features/
│   ├── pokemon_list/
│   │   ├── data/
│   │   │   ├── adapters/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   ├── controllers/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── pokemon_list_module.dart
│   └── pokemon_detail/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Core**: Contains shared code, constants, and base implementations
- **Features**: Contains feature-specific code organized by domain
- **Data**: Handles data operations and API communication
- **Domain**: Contains business logic and entities
- **Presentation**: Handles UI and state management

## Dependencies

- flutter_bloc: State management
- get: Navigation and dependency injection
- http: API communication
- shared_preferences: Local storage
- cached_network_image: Image caching

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Recent Changes

- Updated Pokemon entity structure to match PokeAPI response
- Implemented proper data transformation in models and adapters
- Added caching for offline access
- Improved error handling and null safety
- Updated UI components to work with new data structure

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - email@exemplo.com

Link do Projeto: [https://github.com/seu-usuario/pokeapi](https://github.com/seu-usuario/pokeapi)

# PokeAPI Flutter App

A Flutter application that displays information about Pokémon using the PokeAPI.

## Features

- List of Pokémon with infinite scroll pagination
- Search Pokémon by name with debounce
- View detailed information about each Pokémon
- Filter Pokémon by type and ability
- Caching for offline access
- Clean Architecture implementation
- GetX for state management and navigation
- Shimmer loading effects
- Error handling and user feedback
- Responsive UI design

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

- get: State management and navigation
- http: API communication
- shared_preferences: Local storage
- cached_network_image: Image caching
- shimmer: Loading effects

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

## Features Implementation Details

### Pokemon List

- Infinite scroll pagination
- Grid view with responsive layout
- Loading states with shimmer effects
- Error handling and retry mechanism

### Pokemon Search

- Debounced search to prevent excessive API calls
- Real-time results as you type
- Loading states during search
- Error handling for failed searches

### Pokemon Detail

- Comprehensive information display
- Stats visualization
- Type-based color coding
- Abilities and moves list
- Responsive layout

### Caching

- Local storage for offline access
- Image caching for better performance
- Cache invalidation strategy
- Error handling for offline mode

## Recent Changes

- Implemented GetX for state management and navigation
- Added shimmer loading effects
- Improved error handling and user feedback
- Enhanced UI responsiveness
- Added infinite scroll pagination
- Implemented debounced search
- Added type and ability filtering
- Improved caching mechanism
- Enhanced offline support

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - email@exemplo.com

Link do Projeto: [https://github.com/seu-usuario/pokeapi](https://github.com/seu-usuario/pokeapi)

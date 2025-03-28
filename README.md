# Pokédex App

A Flutter application that uses the PokeAPI to display information about Pokémon.

## Features

### Level 1

- ✅ List of Pokémon with images and names
- ✅ Detail page showing:
  - Image
  - Name
  - Height
  - Weight

### Level 2

- ✅ Local cache for API requests
- ✅ Search filter by name
- ✅ Additional details:
  - Types
  - Abilities

### Level 3

- ✅ Custom splash screen
- ✅ Clear cache when closing the app
- ✅ Pagination in the list
- ✅ Related Pokémon by type and ability
- ✅ Navigation to related Pokémon details
- ✅ Unit tests for business rules

### Extra Features

- ✅ Clean Architecture
- ✅ BLoC for state management
- ✅ Native channel for connectivity detection
- ✅ Offline status message

## How to Run

1. Make sure you have Flutter installed and set up
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Domain**: Contains business logic and entities

  - Entities
  - Repositories (interfaces)
  - Use cases

- **Data**: Implements data sources and repositories

  - Models
  - Repositories (implementations)
  - Data sources

- **Presentation**: Contains UI components and state management
  - Pages
  - Widgets
  - BLoCs

### State Management

The app uses the BLoC (Business Logic Component) pattern for state management, which helps to:

- Separate business logic from UI
- Handle complex state changes
- Make the code more testable

### Dependency Injection

GetIt is used for dependency injection, making it easy to:

- Manage singleton instances
- Provide dependencies to widgets and BLoCs
- Mock dependencies for testing

### Caching

The app implements caching using SharedPreferences to:

- Store API responses locally
- Reduce API calls
- Provide offline support

### Native Features

The app includes a native channel implementation to:

- Detect network connectivity changes
- Display offline status to users
- Handle network-related errors

## Testing

The project includes:

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for main features

To run the tests:

```bash
flutter test
```

## Dependencies

- flutter_bloc: State management
- dio: HTTP client
- get_it: Dependency injection
- equatable: Value equality
- cached_network_image: Image caching
- flutter_cache_manager: Cache management

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

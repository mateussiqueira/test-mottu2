# PokeAPI Flutter App

A Flutter application that consumes the PokeAPI to display information about Pokemon.

## Features

- List all Pokemon with pagination
- Search Pokemon by name
- Filter Pokemon by type
- Filter Pokemon by ability
- Filter Pokemon by move
- Filter Pokemon by evolution chain
- Filter Pokemon by stats
- Filter Pokemon by description
- View detailed information about each Pokemon

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/pokeapi.git
```

2. Navigate to the project directory:

```bash
cd pokeapi
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Architecture

This project follows Clean Architecture principles and is organized into the following layers:

- **Domain**: Contains business logic and entities
- **Data**: Implements repositories and data sources
- **Presentation**: Contains UI components and state management

## Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **injectable**: Dependency injection code generation
- **http**: HTTP client for API requests
- **json_annotation**: JSON serialization
- **freezed**: Code generation for data classes
- **cached_network_image**: Image caching
- **equatable**: Value equality

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [PokeAPI](https://pokeapi.co/) for providing the Pokemon data
- The Flutter and Dart teams for their amazing frameworks

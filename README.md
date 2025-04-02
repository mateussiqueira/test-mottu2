# Pokemon API App

A Flutter application that consumes the PokeAPI to display and manage Pokemon information.

## Features Implemented

### Level 1 ✅

- Pokemon list with images and names
- Pokemon details screen showing:
  - Image
  - Name
  - Height
  - Weight

### Level 2 ✅

- Local cache for API queries using SharedPreferences
- Name filter for the list
- Additional details in Pokemon screen:
  - Types
  - Abilities

### Level 3 ✅

- Pagination in the list
- Unit tests for business rules
- Clean Architecture implementation

### Extra Points ✅

- GetX for state management and dependency injection
- Clean Architecture with:
  - Domain Layer (Entities, Use Cases, Repositories)
  - Data Layer (Models, Data Sources)
  - Presentation Layer (Pages, Widgets, Controllers)

## How to Run

1. Clone the repository:

```bash
git clone https://github.com/yourusername/pokeapi.git
```

2. Navigate to the app directory:

```bash
cd pokeapi/app
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

The project follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   ├── domain/
│   │   └── errors/
│   ├── services/
│   └── data/
│       └── adapters/
├── features/
│   └── pokemon/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── controllers/
│           ├── pages/
│           └── widgets/
└── main.dart
```

## Testing

Run the tests using:

```bash
flutter test
```

## Dependencies

- flutter_dotenv: For environment variables
- get: For state management and dependency injection
- http: For API calls
- shared_preferences: For local storage
- mockito: For testing

## API Reference

The app uses the PokeAPI (https://pokeapi.co/docs/v2) with the following endpoints:

- List of pokemons: /api/v2/pokemon
- Pokemon details: /api/v2/pokemon/{name}
- Types: /api/v2/type
- Abilities: /api/v2/ability

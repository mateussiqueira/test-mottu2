# Pokémon List App

A Flutter application that displays a list of Pokémon with infinite scrolling, search functionality, and caching capabilities.

## Features

- Infinite scrolling list of Pokémon
- Real-time search by name
- Filter Pokémon by type
- Beautiful UI with Material Design 3
- Shimmer loading effects
- Offline caching support
- Pull-to-refresh functionality

## Architecture

The app follows Clean Architecture principles and uses the BLoC pattern for state management. Here's an overview of the project structure:

```
lib/
  ├── core/
  │   ├── di/
  │   │   └── service_locator.dart
  │   └── network/
  │       └── dio_client.dart
  ├── data/
  │   └── repositories/
  │       └── pokemon_repository.dart
  ├── domain/
  │   └── entities/
  │       └── pokemon_entity.dart
  ├── presentation/
  │   ├── blocs/
  │   │   └── pokemon_bloc.dart
  │   ├── pages/
  │   │   └── pokemon_list_page.dart
  │   └── widgets/
  │       ├── pokemon_card.dart
  │       └── pokemon_shimmer_card.dart
  └── main.dart
```

## Dependencies

- flutter_bloc: State management
- equatable: Value equality
- dio: HTTP client
- flutter_cache_manager: Caching
- shimmer: Loading animations
- get_it: Dependency injection

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

## Performance Optimizations

- Implements pagination to load Pokémon in batches of 20
- Caches API responses for 1 hour
- Uses shimmer loading effects for better UX
- Implements efficient search with debouncing
- Optimizes list rendering with proper widget keys

## Contributing

Feel free to open issues and pull requests for any improvements you'd like to add to the project.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - email@exemplo.com

Link do Projeto: [https://github.com/seu-usuario/pokeapi](https://github.com/seu-usuario/pokeapi)

# Pokemon API

Este projeto consiste em uma API de Pokemon com uma camada BFF (Backend for Frontend) e um aplicativo móvel em Flutter.

## Estrutura do Projeto

```
.
├── packages/
│   ├── bff/           # Backend for Frontend em Node.js
│   └── mobile/        # Aplicativo móvel em Flutter
```

## Pré-requisitos

- Node.js 18+
- Flutter 3.0+
- Dart 3.0+
- Git

## Configuração e Execução

### 1. Backend for Frontend (BFF)

O BFF é uma camada intermediária que processa as requisições do aplicativo móvel e se comunica com a API do Pokemon.

1. Entre no diretório do BFF:

   ```bash
   cd packages/bff
   ```

2. Instale as dependências:

   ```bash
   npm install
   ```

3. Configure as variáveis de ambiente:

   ```bash
   cp .env.example .env
   ```

   Edite o arquivo `.env` com suas configurações:

   ```
   PORT=3000
   POKEAPI_URL=https://pokeapi.co/api/v2
   ```

4. Inicie o servidor BFF:
   ```bash
   npm run dev
   ```

O BFF estará rodando em `http://localhost:3000` com as seguintes rotas disponíveis:

- `GET /api/pokemon` - Lista de Pokemons (parâmetros: limit, offset)
- `GET /api/pokemon/:id` - Detalhes de um Pokemon
- `GET /api/pokemon/search?q=:query` - Busca Pokemon por nome
- `GET /api/pokemon/type/:type` - Lista Pokemons por tipo
- `GET /api/pokemon/ability/:ability` - Lista Pokemons por habilidade

### 2. Aplicativo Móvel

O aplicativo móvel consome os dados do BFF para exibir informações sobre Pokemons.

1. Entre no diretório do aplicativo móvel:

   ```bash
   cd packages/mobile
   ```

2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Configure as variáveis de ambiente:

   ```bash
   cp .env.example .env
   ```

   Edite o arquivo `.env` com a URL do BFF:

   ```
   BFF_URL=http://localhost:3000/api
   ```

4. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Funcionalidades do Aplicativo

- Lista de Pokemons com paginação
- Detalhes de Pokemon
- Busca por nome
- Filtro por tipo
- Filtro por habilidade
- Pokemon relacionados

## Arquitetura

### BFF

- Express.js para o servidor
- TypeScript para tipagem estática
- Axios para requisições HTTP
- Jest para testes

### Mobile

- Flutter para a interface do usuário
- GetX para gerenciamento de estado
- Clean Architecture
- Repository Pattern
- BLoC Pattern

## Testes

### BFF

```bash
cd packages/bff
npm test
```

### Mobile

```bash
cd packages/mobile
flutter test
```

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

# Documentação PokeAPI

## Índice

1. [Visão Geral do Projeto](#visão-geral-do-projeto)
2. [Arquitetura](#arquitetura)
   - [Arquitetura Limpa](#arquitetura-limpa)
   - [Arquitetura de Features](#arquitetura-de-features)
   - [Fluxo de Dados](#fluxo-de-dados)
3. [Features](#features)
   - [Lista de Pokémons](#lista-de-pokémons)
   - [Detalhes do Pokémon](#detalhes-do-pokémon)
   - [Busca de Pokémons](#busca-de-pokémons)
4. [Detalhes Técnicos](#detalhes-técnicos)
   - [Dependências](#dependências)
   - [Componentes Principais](#componentes-principais)
   - [Tratamento de Erros](#tratamento-de-erros)
   - [Padrões de Projeto](#padrões-de-projeto)
5. [Pontos de Melhoria](#pontos-de-melhoria)
6. [Guia de Desenvolvimento](#guia-de-desenvolvimento)
7. [Referências](#referências)

## Visão Geral do Projeto

O projeto PokeAPI é uma aplicação Flutter que fornece uma interface completa para interagir com a API de Pokémons. Permite que os usuários naveguem, pesquisem e visualizem informações detalhadas sobre Pokémons.

### Objetivos do Projeto

- Fornecer uma experiência de usuário fluida e responsiva
- Implementar arquitetura limpa e escalável
- Garantir alta performance e baixo consumo de recursos
- Manter código testável e manutenível

### Tecnologias Principais

- **Flutter**: Framework de UI multiplataforma
- **Dart**: Linguagem de programação
- **GetX**: Gerenciamento de estado e injeção de dependência
- **Dio**: Cliente HTTP para requisições de rede
- **SharedPreferences**: Armazenamento local de dados

## Arquitetura

### Arquitetura Limpa

O projeto segue os princípios da Arquitetura Limpa, separando o código em camadas distintas:

1. **Camada de Domínio**

   - **Entidades**: Objetos de negócio principais
     ```dart
     class PokemonEntity {
       final int id;
       final String name;
       final List<String> types;
       final List<String> abilities;
       // ... outros atributos
     }
     ```
   - **Casos de Uso**: Implementações da lógica de negócio

     ```dart
     class GetPokemonListUseCase {
       final IPokemonRepository repository;

       Future<Result<List<PokemonEntity>>> call(int page) async {
         return await repository.getPokemonList(page);
       }
     }
     ```

   - **Interfaces de Repositório**: Contratos para operações de dados
     ```dart
     abstract class IPokemonRepository {
       Future<Result<List<PokemonEntity>>> getPokemonList(int page);
       Future<Result<PokemonEntity>> getPokemonDetail(int id);
     }
     ```

2. **Camada de Dados**

   - **Implementações de Repositório**

     ```dart
     class PokemonRepository implements IPokemonRepository {
       final IPokemonRemoteDataSource remoteDataSource;
       final IPokemonLocalDataSource localDataSource;

       @override
       Future<Result<List<PokemonEntity>>> getPokemonList(int page) async {
         try {
           final result = await remoteDataSource.getPokemonList(page);
           return Right(result);
         } catch (e) {
           return Left(ServerFailure(message: e.toString()));
         }
       }
     }
     ```

   - **Fontes de Dados**
     - Remota: Comunicação com a API
     - Local: Cache e armazenamento persistente
   - **Modelos e Mapeadores**

     ```dart
     class PokemonModel {
       final int id;
       final String name;
       final List<String> types;

       PokemonModel.fromJson(Map<String, dynamic> json) {
         id = json['id'];
         name = json['name'];
         types = List<String>.from(json['types']);
       }

       PokemonEntity toEntity() {
         return PokemonEntity(
           id: id,
           name: name,
           types: types,
         );
       }
     }
     ```

3. **Camada de Apresentação**

   - **Componentes de UI**

     ```dart
     class PokemonListPage extends StatelessWidget {
       final PokemonListController controller;

       @override
       Widget build(BuildContext context) {
         return GetBuilder<PokemonListController>(
           builder: (_) => ListView.builder(
             itemCount: controller.pokemons.length,
             itemBuilder: (context, index) => PokemonCard(
               pokemon: controller.pokemons[index],
             ),
           ),
         );
       }
     }
     ```

   - **Controladores/Blocs**

     ```dart
     class PokemonListController extends GetxController {
       final GetPokemonListUseCase getPokemonList;
       final List<PokemonEntity> pokemons = [];
       bool isLoading = false;

       Future<void> loadPokemons() async {
         isLoading = true;
         update();

         final result = await getPokemonList(1);
         result.fold(
           (failure) => showError(failure.message),
           (pokemons) => this.pokemons.addAll(pokemons),
         );

         isLoading = false;
         update();
       }
     }
     ```

   - **Gerenciamento de Estado**
     - GetX para gerenciamento de estado reativo
     - Injeção de dependência automática
     - Roteamento simplificado

### Arquitetura de Features

Cada feature segue uma estrutura consistente:

```
feature/
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   └── remote/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── controllers/
    ├── pages/
    └── widgets/
```

### Fluxo de Dados

1. **Requisição de Dados**

   ```mermaid
   graph LR
   A[UI] --> B[Controller]
   B --> C[UseCase]
   C --> D[Repository]
   D --> E[RemoteDataSource]
   E --> F[API]
   ```

2. **Tratamento de Resposta**

   ```mermaid
   graph LR
   A[API] --> B[RemoteDataSource]
   B --> C[Repository]
   C --> D[UseCase]
   D --> E[Controller]
   E --> F[UI]
   ```

3. **Cache de Dados**
   ```mermaid
   graph LR
   A[Repository] --> B{Data Local?}
   B -->|Sim| C[LocalDataSource]
   B -->|Não| D[RemoteDataSource]
   D --> E[LocalDataSource]
   ```

## Features

### Lista de Pokémons

**Descrição**: Exibe uma lista paginada de Pokémons com informações básicas.

**Componentes**:

1. **Use Case**

   ```dart
   class GetPokemonListUseCase {
     final IPokemonRepository repository;

     Future<Result<List<PokemonEntity>>> call(int page) async {
       return await repository.getPokemonList(page);
     }
   }
   ```

2. **Controller**

   ```dart
   class PokemonListController extends GetxController {
     final GetPokemonListUseCase getPokemonList;
     final List<PokemonEntity> pokemons = [];
     int currentPage = 1;
     bool isLoading = false;
     bool hasMore = true;

     Future<void> loadMore() async {
       if (isLoading || !hasMore) return;

       isLoading = true;
       update();

       final result = await getPokemonList(currentPage);
       result.fold(
         (failure) => showError(failure.message),
         (newPokemons) {
           if (newPokemons.isEmpty) {
             hasMore = false;
           } else {
             pokemons.addAll(newPokemons);
             currentPage++;
           }
         },
       );

       isLoading = false;
       update();
     }
   }
   ```

3. **UI**
   ```dart
   class PokemonListPage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return GetBuilder<PokemonListController>(
         builder: (controller) => ListView.builder(
           itemCount: controller.pokemons.length + 1,
           itemBuilder: (context, index) {
             if (index == controller.pokemons.length) {
               if (controller.isLoading) {
                 return LoadingIndicator();
               }
               if (controller.hasMore) {
                 controller.loadMore();
                 return LoadingIndicator();
               }
               return SizedBox.shrink();
             }
             return PokemonCard(pokemon: controller.pokemons[index]);
           },
         ),
       );
     }
   }
   ```

**Melhorias**:

1. **Cache**

   ```dart
   class PokemonLocalDataSource {
     final SharedPreferences prefs;

     Future<List<PokemonEntity>> getCachedPokemons(int page) async {
       final key = 'pokemons_page_$page';
       final json = prefs.getString(key);
       if (json != null) {
         final data = jsonDecode(json);
         return data.map((e) => PokemonEntity.fromJson(e)).toList();
       }
       return [];
     }

     Future<void> cachePokemons(int page, List<PokemonEntity> pokemons) async {
       final key = 'pokemons_page_$page';
       final json = jsonEncode(pokemons.map((e) => e.toJson()).toList());
       await prefs.setString(key, json);
     }
   }
   ```

2. **Filtros**

   ```dart
   class PokemonFilter {
     final String? name;
     final List<String>? types;
     final int? generation;

     bool matches(PokemonEntity pokemon) {
       if (name != null && !pokemon.name.toLowerCase().contains(name!.toLowerCase())) {
         return false;
       }
       if (types != null && !types!.every((type) => pokemon.types.contains(type))) {
         return false;
       }
       if (generation != null && pokemon.generation != generation) {
         return false;
       }
       return true;
     }
   }
   ```

### Detalhes do Pokémon

**Descrição**: Mostra informações detalhadas sobre um Pokémon específico.

**Componentes**:

1. **Use Case**

   ```dart
   class GetPokemonDetailUseCase {
     final IPokemonRepository repository;

     Future<Result<PokemonEntity>> call(int id) async {
       return await repository.getPokemonDetail(id);
     }
   }
   ```

2. **Controller**

   ```dart
   class PokemonDetailController extends GetxController {
     final GetPokemonDetailUseCase getPokemonDetail;
     PokemonEntity? pokemon;
     bool isLoading = false;

     Future<void> loadPokemon(int id) async {
       isLoading = true;
       update();

       final result = await getPokemonDetail(id);
       result.fold(
         (failure) => showError(failure.message),
         (pokemon) => this.pokemon = pokemon,
       );

       isLoading = false;
       update();
     }
   }
   ```

3. **UI**
   ```dart
   class PokemonDetailPage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return GetBuilder<PokemonDetailController>(
         builder: (controller) {
           if (controller.isLoading) {
             return LoadingIndicator();
           }
           if (controller.pokemon == null) {
             return ErrorWidget();
           }
           return PokemonDetailView(pokemon: controller.pokemon!);
         },
       );
     }
   }
   ```

**Melhorias**:

1. **Visualização 3D**

   ```dart
   class Pokemon3DViewer extends StatefulWidget {
     final PokemonEntity pokemon;

     @override
     Widget build(BuildContext context) {
       return ModelViewer(
         src: 'assets/models/${pokemon.id}.glb',
         alt: pokemon.name,
         autoRotate: true,
         cameraControls: true,
       );
     }
   }
   ```

2. **Animações de Movimentos**

   ```dart
   class MoveAnimation extends StatefulWidget {
     final String moveName;

     @override
     Widget build(BuildContext context) {
       return Lottie.asset(
         'assets/animations/moves/$moveName.json',
         repeat: true,
       );
     }
   }
   ```

### Busca de Pokémons

**Descrição**: Permite pesquisar Pokémons por diversos critérios.

**Componentes**:

1. **Use Cases**

   ```dart
   class SearchPokemonsUseCase {
     final IPokemonRepository repository;

     Future<Result<List<PokemonEntity>>> call(SearchParams params) async {
       return await repository.searchPokemons(params);
     }
   }

   class SearchParams {
     final String? name;
     final List<String>? types;
     final List<String>? abilities;
     final int? minHeight;
     final int? maxHeight;
     final int? minWeight;
     final int? maxWeight;
   }
   ```

2. **Controller**

   ```dart
   class PokemonSearchController extends GetxController {
     final SearchPokemonsUseCase searchPokemons;
     final List<PokemonEntity> results = [];
     bool isLoading = false;

     Future<void> search(SearchParams params) async {
       isLoading = true;
       update();

       final result = await searchPokemons(params);
       result.fold(
         (failure) => showError(failure.message),
         (pokemons) => results.assignAll(pokemons),
       );

       isLoading = false;
       update();
     }
   }
   ```

3. **UI**
   ```dart
   class PokemonSearchPage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return GetBuilder<PokemonSearchController>(
         builder: (controller) => Column(
           children: [
             SearchBar(
               onChanged: (query) => controller.search(SearchParams(name: query)),
             ),
             if (controller.isLoading)
               LoadingIndicator()
             else
               PokemonGrid(pokemons: controller.results),
           ],
         ),
       );
     }
   }
   ```

**Melhorias**:

1. **Busca Avançada**

   ```dart
   class AdvancedSearchDialog extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return GetBuilder<PokemonSearchController>(
         builder: (controller) => Form(
           child: Column(
             children: [
               TextFormField(
                 decoration: InputDecoration(labelText: 'Nome'),
                 onChanged: (value) => controller.updateName(value),
               ),
               MultiSelectChipField(
                 items: PokemonType.values.map((type) => MultiSelectItem(type, type.name)).toList(),
                 onSelectionChanged: (values) => controller.updateTypes(values),
               ),
               // ... outros campos
             ],
           ),
         ),
       );
     }
   }
   ```

2. **Histórico de Buscas**

   ```dart
   class SearchHistory {
     final SharedPreferences prefs;
     final int maxHistory = 10;

     Future<List<String>> getHistory() async {
       return prefs.getStringList('search_history') ?? [];
     }

     Future<void> addToHistory(String query) async {
       final history = await getHistory();
       history.insert(0, query);
       if (history.length > maxHistory) {
         history.removeLast();
       }
       await prefs.setStringList('search_history', history);
     }
   }
   ```

## Detalhes Técnicos

### Dependências

1. **Gerenciamento de Estado**

   ```yaml
   dependencies:
     get: ^4.6.5
   ```

2. **Cliente HTTP**

   ```yaml
   dependencies:
     dio: ^4.0.6
   ```

3. **Armazenamento Local**

   ```yaml
   dependencies:
     shared_preferences: ^2.0.15
   ```

4. **Carregamento de Imagens**

   ```yaml
   dependencies:
     cached_network_image: ^3.2.3
   ```

5. **Tratamento de Erros**
   ```yaml
   dependencies:
     dartz: ^0.10.1
   ```

### Componentes Principais

1. **Tipo Result**

   ```dart
   typedef Result<T> = Either<Failure, T>;

   extension ResultExtension<T> on Result<T> {
     T? getOrNull() => fold((_) => null, (value) => value);
     T getOrElse(T defaultValue) => fold((_) => defaultValue, (value) => value);
     Result<R> map<R>(R Function(T) f) => fold(
       (failure) => Left(failure),
       (value) => Right(f(value)),
     );
   }
   ```

2. **Hierarquia de Falhas**

   ```dart
   abstract class Failure {
     final String message;
     const Failure({required this.message});
   }

   class ServerFailure extends Failure {
     const ServerFailure({required String message}) : super(message: message);
   }

   class CacheFailure extends Failure {
     const CacheFailure({required String message}) : super(message: message);
   }

   class NetworkFailure extends Failure {
     const NetworkFailure({required String message}) : super(message: message);
   }
   ```

3. **Padrão de Repositório**

   ```dart
   abstract class IRepository<T> {
     Future<Result<T>> get(int id);
     Future<Result<List<T>>> getAll();
     Future<Result<void>> save(T entity);
     Future<Result<void>> delete(int id);
   }

   class Repository<T> implements IRepository<T> {
     final IRemoteDataSource<T> remoteDataSource;
     final ILocalDataSource<T> localDataSource;

     @override
     Future<Result<T>> get(int id) async {
       try {
         final localResult = await localDataSource.get(id);
         if (localResult != null) {
           return Right(localResult);
         }

         final remoteResult = await remoteDataSource.get(id);
         await localDataSource.save(remoteResult);
         return Right(remoteResult);
       } catch (e) {
         return Left(ServerFailure(message: e.toString()));
       }
     }
   }
   ```

### Tratamento de Erros

1. **Erros de Domínio**

   ```dart
   class DomainError implements Exception {
     final String message;
     final String code;

     DomainError({required this.message, required this.code});
   }
   ```

2. **Mapeamento de Erros**

   ```dart
   class ErrorMapper {
     static Failure mapException(Exception exception) {
       if (exception is DioError) {
         return _mapDioError(exception);
       }
       if (exception is FormatException) {
         return FormatFailure(message: exception.message);
       }
       return UnknownFailure(message: exception.toString());
     }

     static Failure _mapDioError(DioError error) {
       switch (error.type) {
         case DioErrorType.connectTimeout:
         case DioErrorType.sendTimeout:
         case DioErrorType.receiveTimeout:
           return TimeoutFailure(message: 'Tempo de requisição excedido');
         case DioErrorType.response:
           return _mapResponseError(error.response!);
         case DioErrorType.cancel:
           return CancelledFailure(message: 'Requisição cancelada');
         default:
           return NetworkFailure(message: 'Erro de rede');
       }
     }
   }
   ```

3. **Tratamento na UI**
   ```dart
   class ErrorHandler {
     static void handleError(BuildContext context, Failure failure) {
       final message = failure.message;
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text(message),
           backgroundColor: Colors.red,
         ),
       );
     }
   }
   ```

### Padrões de Projeto

1. **Factory Method**

   ```dart
   abstract class PokemonFactory {
     PokemonEntity createPokemon(Map<String, dynamic> json);
   }

   class StandardPokemonFactory implements PokemonFactory {
     @override
     PokemonEntity createPokemon(Map<String, dynamic> json) {
       return PokemonEntity(
         id: json['id'],
         name: json['name'],
         types: List<String>.from(json['types']),
       );
     }
   }
   ```

2. **Strategy**

   ```dart
   abstract class SearchStrategy {
     Future<List<PokemonEntity>> search(String query);
   }

   class NameSearchStrategy implements SearchStrategy {
     @override
     Future<List<PokemonEntity>> search(String query) {
       // Implementação da busca por nome
     }
   }

   class TypeSearchStrategy implements SearchStrategy {
     @override
     Future<List<PokemonEntity>> search(String query) {
       // Implementação da busca por tipo
     }
   }
   ```

3. **Observer**

   ```dart
   class PokemonObserver {
     final List<Function(PokemonEntity)> _listeners = [];

     void addListener(Function(PokemonEntity) listener) {
       _listeners.add(listener);
     }

     void notifyListeners(PokemonEntity pokemon) {
       for (final listener in _listeners) {
         listener(pokemon);
       }
     }
   }
   ```

## Pontos de Melhoria

### Melhorias de Arquitetura

1. Implementar container de injeção de dependência adequado
2. Adicionar cobertura de testes unitários
3. Implementar tratamento adequado de limites de erro
4. Adicionar sistema de logging adequado
5. Implementar padrão de retry para requisições
6. Adicionar monitoramento de performance
7. Implementar cache distribuído

### Melhorias de Features

1. **Lista de Pokémons**

   - Adicionar toggle de visualização em grade/lista
   - Implementar pull-to-refresh
   - Adicionar skeletons de carregamento
   - Implementar cache inteligente
   - Adicionar filtros avançados
   - Implementar ordenação personalizada

2. **Detalhes do Pokémon**

   - Adicionar visualizador 3D
   - Implementar animações de movimentos
   - Adicionar informações de reprodução
   - Implementar comparação com outros Pokémons
   - Adicionar estatísticas detalhadas
   - Implementar visualização de evolução

3. **Busca**
   - Adicionar busca por voz
   - Implementar sugestões de busca
   - Adicionar filtros de busca
   - Implementar histórico de buscas
   - Adicionar favoritos
   - Implementar busca avançada

### Melhorias de Performance

1. Implementar cache de imagens adequado
2. Adicionar pré-busca de dados
3. Otimizar requisições de rede
4. Implementar persistência de estado adequada
5. Implementar lazy loading
6. Otimizar renderização de listas
7. Implementar compressão de dados

### Melhorias de UI/UX

1. Adicionar suporte a tema claro/escuro
2. Implementar animações adequadas
3. Adicionar suporte a acessibilidade
4. Implementar estados de erro adequados
5. Adicionar feedback visual para ações
6. Implementar gestos personalizados
7. Adicionar suporte a diferentes tamanhos de tela

### Melhorias de Testes

1. Adicionar testes unitários para casos de uso
2. Adicionar testes de widget
3. Adicionar testes de integração
4. Implementar relatório de cobertura de testes
5. Adicionar testes de performance
6. Implementar testes de acessibilidade
7. Adicionar testes de usabilidade

### Melhorias de Documentação

1. Adicionar documentação da API
2. Adicionar diagramas de arquitetura
3. Adicionar documentação de componentes
4. Adicionar guias de contribuição
5. Adicionar exemplos de código
6. Implementar documentação interativa
7. Adicionar tutoriais passo a passo

### Melhorias de Segurança

1. Implementar autenticação adequada
2. Adicionar criptografia de dados sensíveis
3. Implementar validação de entrada
4. Adicionar proteção contra ataques comuns
5. Implementar sanitização de dados
6. Adicionar logging de segurança
7. Implementar controle de acesso

### Melhorias de Manutenção

1. Implementar análise estática de código
2. Adicionar ferramentas de formatação
3. Implementar CI/CD adequado
4. Adicionar monitoramento de erros
5. Implementar versionamento semântico
6. Adicionar changelog
7. Implementar revisão de código

## Guia de Desenvolvimento

### Configuração do Ambiente

1. **Requisitos**

   - Flutter SDK
   - Dart SDK
   - Android Studio / VS Code
   - Git

2. **Instalação**

   ```bash
   # Clonar o repositório
   git clone https://github.com/seu-usuario/pokeapi.git

   # Instalar dependências
   flutter pub get

   # Executar o projeto
   flutter run
   ```

### Convenções de Código

1. **Nomenclatura**

   - Classes: PascalCase
   - Métodos: camelCase
   - Variáveis: camelCase
   - Constantes: SCREAMING_SNAKE_CASE

2. **Organização de Arquivos**

   ```
   lib/
   ├── core/
   │   ├── config/
   │   ├── error/
   │   └── result/
   ├── features/
   │   └── pokemon/
   │       ├── data/
   │       ├── domain/
   │       └── presentation/
   └── main.dart
   ```

3. **Documentação**
   - Comentários em português
   - Documentação de classes e métodos
   - Exemplos de uso quando necessário

### Processo de Desenvolvimento

1. **Criação de Features**

   - Criar branch a partir de develop
   - Implementar feature seguindo TDD
   - Criar PR para revisão
   - Atualizar documentação

2. **Code Review**

   - Verificar padrões de código
   - Testar funcionalidades
   - Validar documentação
   - Aprovar ou solicitar alterações

3. **Deploy**
   - Atualizar versão
   - Gerar changelog
   - Criar tag
   - Fazer deploy

## Referências

1. **Documentação Oficial**

   - [Flutter](https://flutter.dev/docs)
   - [Dart](https://dart.dev/guides)
   - [GetX](https://pub.dev/packages/get)

2. **Arquitetura**

   - [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
   - [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)

3. **APIs**

   - [PokeAPI](https://pokeapi.co/)
   - [Dio](https://pub.dev/packages/dio)

4. **Ferramentas**
   - [VS Code](https://code.visualstudio.com/)
   - [Android Studio](https://developer.android.com/studio)
   - [Git](https://git-scm.com/)

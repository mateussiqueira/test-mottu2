# Pokédex Flutter

Um aplicativo Flutter que integra com a PokeAPI para exibir informações sobre Pokémon.

## Funcionalidades

- Lista de Pokémon com paginação
- Detalhes de cada Pokémon
- Monitoramento de conectividade
- Cache de imagens
- Interface moderna com Material Design 3
- Gerenciamento de estado com GetX
- Arquitetura limpa (Clean Architecture)

## Tecnologias Utilizadas

- Flutter 3.29.2
- Dart 3.7.2
- GetX para gerenciamento de estado e injeção de dependência
- HTTP para requisições à API
- Cached Network Image para cache de imagens
- Shared Preferences para armazenamento local
- Kotlin para código nativo Android

## Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/
│   ├── services/
│   └── utils/
├── features/
│   ├── pokemon_list/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── pokemon_detail/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## Configuração do Ambiente

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/pokeapi.git
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure o arquivo `local.properties`:
```properties
flutter.sdk=/caminho/para/seu/flutter
```

4. Execute o aplicativo:
```bash
flutter run
```

## Arquitetura

O projeto segue os princípios da Clean Architecture, com as seguintes camadas:

- **Data**: Implementação dos repositórios e fontes de dados
- **Domain**: Regras de negócio e casos de uso
- **Presentation**: Interface do usuário e widgets

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - email@exemplo.com

Link do Projeto: [https://github.com/seu-usuario/pokeapi](https://github.com/seu-usuario/pokeapi)

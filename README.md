# PokeAPI Mobile App

Um aplicativo Flutter que consome a PokeAPI, permitindo visualizar uma lista de Pokémon e seus detalhes. O projeto pode ser executado de duas maneiras:

1. Com BFF (Backend for Frontend)
2. Com API direta (consumindo a PokeAPI diretamente)

## Pré-requisitos

- Flutter SDK
- Node.js (para rodar o BFF)
- Git

## Configuração

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/pokeapi.git
cd pokeapi
```

2. Instale as dependências do Flutter:
```bash
cd app
flutter pub get
```

3. Se for usar o BFF, instale as dependências do Node.js:
```bash
cd ../bff
npm install
```

## Executando o Projeto

O projeto possui um script de execução que facilita o processo. Na raiz do projeto, execute:

```bash
./run.sh
```

Você terá as seguintes opções:

1. **Executar com BFF**
   - Instala as dependências do BFF
   - Inicia o servidor BFF
   - Executa o aplicativo Flutter

2. **Executar com API direta**
   - Executa o aplicativo Flutter consumindo a PokeAPI diretamente

3. **Instalar dependências**
   - Instala todas as dependências necessárias (Flutter e BFF)

4. **Sair**
   - Encerra o script

## Estrutura do Projeto

O projeto segue a arquitetura Clean Architecture e está organizado da seguinte forma:

```
app/
├── lib/
│   ├── core/           # Configurações e utilitários
│   ├── features/       # Módulos da aplicação
│   │   ├── pokemon/    # Feature de listagem de Pokémon
│   │   └── pokemon_detail/  # Feature de detalhes do Pokémon
│   └── main.dart       # Ponto de entrada da aplicação
bff/
├── src/               # Código fonte do BFF
└── package.json       # Dependências do BFF
```

## Tecnologias Utilizadas

- Flutter
- GetX (Gerenciamento de Estado e Navegação)
- Clean Architecture
- Node.js (BFF)
- PokeAPI

## Funcionalidades

- Listagem de Pokémon com paginação
- Busca de Pokémon por nome
- Visualização detalhada de cada Pokémon
- Lista de Pokémon relacionados por tipo e habilidade
- Suporte a modo offline (quando usando BFF)

## 🚀 Funcionalidades Implementadas

### Nível 1
- [x] Listagem de Pokémons com:
  - Imagem
  - Nome
- [x] Tela de detalhes com:
  - Imagem
  - Nome
  - Altura
  - Peso

### Nível 2
- [x] Cache local das consultas à API
- [x] Filtro por nome na listagem
- [x] Tela de detalhes expandida com:
  - Tipos
  - Habilidades

### Nível 3
- [x] Splash screen customizada
- [x] Limpeza do cache ao fechar o app
- [x] Paginação na listagem
- [x] Pokémons relacionados por tipo e habilidade
- [x] Navegação para detalhes de pokémons relacionados
- [x] Testes de unidade para regras de negócio

### Pontos Extras
- [x] Uso do GetX para gerenciamento de estado e navegação
- [x] Arquitetura Clean Architecture com:
  - Domain (entities, repositories, use cases)
  - Data (repositories, data sources)
  - Presentation (controllers, pages, widgets)

## 🏗️ Arquitetura

O projeto utiliza Clean Architecture com as seguintes camadas:

```
lib/
├── core/
│   ├── domain/
│   │   ├── entities/
│   │   ├── errors/
│   │   ├── repositories/
│   │   ├── result.dart
│   │   └── validators/
│   ├── presentation/
│   │   ├── adapters/
│   │   ├── constants/
│   │   └── routes/
│   └── config/
├── features/
│   ├── pokemon/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
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

## 🧪 Testes

O projeto inclui testes de unidade para as regras de negócio. Para executar os testes:

```bash
cd app
flutter test
```

## 📱 Plataformas Suportadas

- iOS
- Android

## 🔧 Configuração do Ambiente

### iOS
1. Instale o Xcode
2. Configure o CocoaPods:
```bash
cd ios
pod install
```

### Android
1. Instale o Android Studio
2. Configure um emulador Android ou conecte um dispositivo físico

## 📦 Dependências Principais

- GetX: Gerenciamento de estado e navegação
- Dio: Cliente HTTP
- SharedPreferences: Cache local
- Mockito: Testes

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

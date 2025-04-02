# PokeAPI Mobile App

Aplicativo Flutter que consome a PokeAPI para exibir informações sobre Pokémon. O projeto pode ser executado de duas formas: consumindo diretamente a API ou através de um BFF (Backend for Frontend).

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

## 🛠️ Como Executar

### Pré-requisitos
- Flutter SDK
- Dart SDK
- Node.js (para o BFF)
- iOS Simulator ou Android Emulator

### Usando o Script de Automação (Recomendado)

O projeto inclui um script de automação que facilita a execução e configuração do ambiente:

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/pokeapi.git
cd pokeapi
```

2. Dê permissão de execução ao script:
```bash
chmod +x run.sh
```

3. Execute o script:
```bash
./run.sh
```

O script oferece as seguintes opções:
- Executar com BFF
- Executar com API direta
- Instalar dependências
- Sair

O script também:
- Verifica se todos os pré-requisitos estão instalados
- Instala automaticamente as dependências necessárias
- Configura o ambiente iOS (quando aplicável)
- Gerencia o ciclo de vida do BFF

### Executando Manualmente

#### Com BFF

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/pokeapi.git
cd pokeapi
```

2. Instale as dependências do BFF:
```bash
cd bff
npm install
```

3. Inicie o BFF:
```bash
npm run start:dev
```

4. Em outro terminal, instale as dependências do Flutter:
```bash
cd app
flutter pub get
```

5. Execute o app:
```bash
flutter run
```

#### Com API Direta

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

3. Configure o arquivo `app/lib/core/config/app_config.dart`:
```dart
class AppConfig {
  static const bool useBff = false; // Altere para false para usar a API diretamente
}
```

4. Execute o app:
```bash
flutter run
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

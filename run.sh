#!/bin/bash

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para exibir mensagens
print_message() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verifica se o Flutter está instalado
check_flutter() {
    if ! command -v flutter &>/dev/null; then
        print_error "Flutter não está instalado. Por favor, instale o Flutter primeiro."
        exit 1
    fi
}

# Verifica se o Node.js está instalado
check_node() {
    if ! command -v node &>/dev/null; then
        print_error "Node.js não está instalado. Por favor, instale o Node.js primeiro."
        exit 1
    fi
}

# Verifica se o CocoaPods está instalado (para iOS)
check_cocoapods() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v pod &>/dev/null; then
            print_error "CocoaPods não está instalado. Por favor, instale o CocoaPods primeiro."
            exit 1
        fi
    fi
}

# Instala dependências do Flutter
install_flutter_deps() {
    print_message "Instalando dependências do Flutter..."
    cd app
    flutter pub get
    cd ..
}

# Instala dependências do BFF
install_bff_deps() {
    print_message "Instalando dependências do BFF..."
    cd bff
    npm install
    cd ..
}

# Configura o ambiente iOS
setup_ios() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_message "Configurando ambiente iOS..."
        cd app/ios
        pod install
        cd ../..
    fi
}

# Inicia o BFF
start_bff() {
    print_message "Iniciando BFF..."
    cd bff
    npm run start:dev &
    BFF_PID=$!
    cd ..
}

# Para o BFF
stop_bff() {
    if [ ! -z "$BFF_PID" ]; then
        print_message "Parando BFF..."
        kill $BFF_PID
    fi
}

# Executa o app Flutter
run_flutter_app() {
    print_message "Executando aplicativo Flutter..."
    cd app
    flutter run
    cd ..
}

# Função principal
main() {
    # Verifica pré-requisitos
    check_flutter
    check_node
    check_cocoapods

    # Menu principal
    echo -e "\n${BLUE}=== PokeAPI Mobile App ===${NC}"
    echo "1. Executar com BFF"
    echo "2. Executar com API direta"
    echo "3. Instalar dependências"
    echo "4. Sair"
    echo -e "\nEscolha uma opção: "
    read option

    case $option in
    1)
        # Executa com BFF
        install_bff_deps
        install_flutter_deps
        setup_ios
        start_bff
        run_flutter_app
        stop_bff
        ;;
    2)
        # Executa com API direta
        install_flutter_deps
        setup_ios
        run_flutter_app
        ;;
    3)
        # Instala todas as dependências
        install_bff_deps
        install_flutter_deps
        setup_ios
        print_success "Todas as dependências foram instaladas com sucesso!"
        ;;
    4)
        print_message "Saindo..."
        exit 0
        ;;
    *)
        print_error "Opção inválida!"
        exit 1
        ;;
    esac
}

# Executa o script
main

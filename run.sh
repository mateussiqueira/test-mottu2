#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Função para verificar se um comando está instalado
check_command() {
    if ! command -v $1 &>/dev/null; then
        echo -e "${RED}Erro: $1 não está instalado${NC}"
        exit 1
    fi
}

# Função para instalar dependências do Flutter
install_flutter_deps() {
    echo -e "${YELLOW}[INFO] Instalando dependências do Flutter...${NC}"
    cd app
    flutter pub get
    cd ..
}

# Função para instalar dependências do BFF
install_bff_deps() {
    echo -e "${YELLOW}[INFO] Instalando dependências do BFF...${NC}"
    cd bff
    npm install
    cd ..
}

# Função para configurar ambiente iOS
setup_ios() {
    echo -e "${YELLOW}[INFO] Configurando ambiente iOS...${NC}"
    cd app/ios
    pod install
    cd ../..
}

# Função para iniciar o BFF
start_bff() {
    echo -e "${YELLOW}[INFO] Iniciando BFF...${NC}"
    cd bff
    npm run start:dev &
    BFF_PID=$!
    cd ..
}

# Função para parar o BFF
stop_bff() {
    echo -e "${YELLOW}[INFO] Parando BFF...${NC}"
    if [ ! -z "$BFF_PID" ]; then
        kill $BFF_PID 2>/dev/null || true
    fi
}

# Função para executar o app Flutter
run_flutter_app() {
    echo -e "${YELLOW}[INFO] Executando aplicativo Flutter...${NC}"
    cd app
    flutter run
    cd ..
}

# Verificar pré-requisitos
check_command "flutter"
check_command "node"
check_command "pod"

# Menu principal
while true; do
    echo -e "\n=== PokeAPI Mobile App ==="
    echo "1. Executar com BFF"
    echo "2. Executar com API direta"
    echo "3. Instalar dependências"
    echo "4. Sair"
    echo
    read -p "Escolha uma opção: " choice

    case $choice in
    1)
        install_bff_deps
        install_flutter_deps
        setup_ios
        start_bff
        run_flutter_app
        stop_bff
        ;;
    2)
        install_flutter_deps
        setup_ios
        run_flutter_app
        ;;
    3)
        install_bff_deps
        install_flutter_deps
        setup_ios
        echo -e "${GREEN}[SUCCESS] Dependências instaladas com sucesso!${NC}"
        ;;
    4)
        stop_bff
        echo -e "${GREEN}[INFO] Saindo...${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}[ERROR] Opção inválida${NC}"
        ;;
    esac
done

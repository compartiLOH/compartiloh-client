#!/bin/bash

set -e

INSTALATION_FOLDER=$(cd "$(dirname "$0")" && pwd)
AGENT_FOLDER=$(ls -d "$INSTALATION_FOLDER/agent"/*/)
GIT_FOLDER="$INSTALATION_FOLDER/git"

# Función para conectar
connect() {
    cd $AGENT_FOLDER
    ./agent-client
}

# Función para actualizar
update() {
    cd $GIT_FOLDER
    LAST_LOCAL_COMMIT=$(git log -1 --format="%H")
    git fetch && LAST_REMOTE_COMMIT=$(git rev-parse origin/$(git rev-parse --abbrev-ref HEAD))
    if [ "$LAST_LOCAL_COMMIT" = "$LAST_REMOTE_COMMIT" ]; then
        echo "Client updated"
    else
        echo "Updating client"
        git pull origin main
        ACTUAL_DIST=$(basename "$AGENT_FOLDER")
        DIST_VERSION="lib/$ACTUAL_DIST"
        cp -p -r "$GIT_FOLDER/cli/compartiloh.sh" "$INSTALATION_FOLDER/cloh"
        cp -p -r "$GIT_FOLDER/$DIST_VERSION" "$INSTALATION_FOLDER/agent"
        echo "Client updated. Please configure new token."
    fi
}

# Función para mostrar la ayuda
show_help() {
    echo ""
    echo "connect      Connect the resource to the system. Requires token configuration"
    echo "update       Update  cloh CLI"
    echo "help         Show this help message"
}

# Verificar el número de argumentos
if [ $# -eq 0 ]; then
    echo "At least one parameter is required"
    show_help
    exit 1
fi

# Manejar los parámetros
case "$1" in
    "connect")
        connect
        ;;
    "update")
        update
        ;;
    "help")
        show_help
        ;;
    *)
        echo "Error: Parámetro no reconocido. Consulta la ayuda:"
        show_help
        ;;
esac
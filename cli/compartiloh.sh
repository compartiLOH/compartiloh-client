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
    echo $GIT_FOLDER
    LAST_LOCAL_COMMIT=$(git log -1 --format="%H")
    git fetch && LAST_REMOTE_COMMIT=$(git rev-parse origin/$(git rev-parse --abbrev-ref HEAD))
    if [ "$LAST_LOCAL_COMMIT" = "$LAST_REMOTE_COMMIT" ]; then
        echo "Cliente actualizado"
    else
        echo "Actualizando cliente"
        git pull origin main
        ACTUAL_DIST=$(basename "$AGENT_FOLDER")
        DIST_VERSION="lib/$ACTUAL_DIST"
        cp -p -r "$GIT_FOLDER/$DIST_VERSION" "$INSTALATION_FOLDER/agent"
        echo "Cliente actualizado. Recuerde configurar token nuevamente"
    fi
}

# Función para mostrar la ayuda
show_help() {
    echo ""
    echo "connect      Conectar el recurso al sistema. Requiere configuracion de token"
    echo "update       Actualizar CLI de compartiloh"
    echo "help         Mostrar este mensaje de ayuda"
}

# Verificar el número de argumentos
if [ $# -eq 0 ]; then
    echo "Se requiere al menos un parámetro."
    show_help
    exit 1
fi

# Manejar los parámetros
case "$1" in
    "connect")
        echo "Conectando..."
        connect
        ;;
    "update")
        echo "Actualizando..."
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
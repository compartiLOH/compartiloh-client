#!/bin/bash

set -e

#Validacion de entrada
if [ $# -eq 0 ]; then
    echo "Error: Se requiere al menos el parámetro de version a instalar"
    exit 1
fi

#Configuracion de carpetas de instalacion
DIST_VERSION="lib/$1"
INSTALATION_FOLDER="$HOME/.compartiloh"
rm -rf $INSTALATION_FOLDER && mkdir -p $INSTALATION_FOLDER
mkdir -p "$INSTALATION_FOLDER/agent"
mkdir -p "$INSTALATION_FOLDER/git"

#Instalando el cliente (accesible desde cualquier ruta)
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cp -p -r "$SCRIPT_DIR/$DIST_VERSION" "$INSTALATION_FOLDER/agent"
cp -p -r "$SCRIPT_DIR/cli/compartiloh.sh" "$INSTALATION_FOLDER/cloh"

#Configuracion de repositorio
REPO="https://github.com/compartiLOH/compartiloh-client"
git clone $REPO "$INSTALATION_FOLDER/git"
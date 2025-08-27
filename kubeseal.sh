#!/bin/bash
# Script para instalar la última versión de kubeseal en Linux
set -e

echo "Detectando la última versión de kubeseal..."
LATEST=$(curl -s https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest | grep tag_name | cut -d '"' -f4)

echo "Descargando kubeseal versión $LATEST..."
curl -LO "https://github.com/bitnami-labs/sealed-secrets/releases/download/${LATEST}/kubeseal-${LATEST#v}-linux-amd64.tar.gz"

echo "Extrayendo binario..."
tar -xzf "kubeseal-${LATEST#v}-linux-amd64.tar.gz" kubeseal

echo "Instalando kubeseal en /usr/local/bin (requiere sudo)..."
sudo install -m 0755 kubeseal /usr/local/bin/kubeseal

echo "Verificando instalación:"
kubeseal --version
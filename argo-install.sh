#!/bin/bash
set -e

echo "🚀 Preparando instalación limpia de Minikube + Argo CD..."

# --- Revisar si Minikube ya está instalado ---
if command -v minikube &> /dev/null; then
    echo "⚠️ Minikube detectado, eliminando clúster previo..."
    minikube delete || true
    sudo rm -f /usr/local/bin/minikube
fi

# --- Revisar si Docker está instalado ---
if ! command -v docker &> /dev/null; then
    echo "🐳 Instalando Docker..."
    sudo apt-get update -y
    sudo apt-get install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
fi

# --- Dependencias ---
echo "🔧 Instalando dependencias..."
sudo apt-get install -y curl apt-transport-https conntrack

# --- Instalar Minikube ---
echo "📦 Instalando Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# --- Instalar kubectl ---
if ! command -v kubectl &> /dev/null; then
    echo "📥 Instalando kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install kubectl /usr/local/bin/
    rm kubectl
fi

# --- Iniciar Minikube ---
echo "☸️ Iniciando Minikube con Docker..."
minikube start --driver=docker

# --- Instalar Argo CD ---
echo "🌀 Creando namespace para Argo CD..."
kubectl create namespace argocd || true

echo "📌 Instalando Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "🔑 Aplicando ServiceAccount 'argocd-manager' desde archivo YAML..."
kubectl apply -f argocd-manager.yml
echo "✅ ServiceAccount creado"

# --- Obtener token del ServiceAccount ---
ARGO_TOKEN=$(kubectl -n argocd get secret $(kubectl -n argocd get sa/argocd-manager -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode)

# --- Registrar el cluster local en Argo CD ---
echo "🌐 Registrando cluster local en Argo CD..."
argocd cluster add minikube --name local-cluster --insecure --token $ARGO_TOKEN || true

# --- Mostrar instrucciones ---
echo "✅ Instalación completada"
echo "Para acceder a la UI de Argo CD ejecuta:"
echo "  kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "Usuario inicial: admin"
echo " hazlo en una ventana distinta la anterior queda tomada"
echo "Contraseña: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
echo "Luego abre en tu navegador: https://localhost:8080"

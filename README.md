# ArgoCD Installation Script

Este repositorio contiene un script de instalación para ArgoCD en un clúster de Kubernetes.

## Descripción

El archivo `argo-install.sh` es un script de shell que automatiza la instalación de ArgoCD, una herramienta de entrega continua para Kubernetes.


## Uso

1. Crea el namespace `argo-example` en tu clúster de Kubernetes:
   ```bash
   kubectl create namespace argo-example
   ```

2. Da permisos de ejecución al script:
   ```bash
   chmod +x argo-install.sh
   ```

3. Ejecuta el script:
   ```bash
   ./argo-install.sh
   ```

Asegúrate de tener acceso a un clúster de Kubernetes y de tener instalado `kubectl` antes de ejecutar el script.

## Requisitos
- Acceso a un clúster de Kubernetes
- `kubectl` instalado y configurado

## Notas
- El script puede requerir privilegios de administrador dependiendo de la configuración de tu entorno.
- Consulta la documentación oficial de [ArgoCD](https://argo-cd.readthedocs.io/) para más información.

## Licencia
Este proyecto está bajo la licencia MIT.

---

Crea el namespace `argo-example` en tu clúster de Kubernetes:
```bash
kubectl create namespace argo-example

Luego puedes configurar la app desde la web
```

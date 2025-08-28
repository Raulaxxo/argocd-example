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


## Configuración adicional

Crea el namespace `argo-example` en tu clúster de Kubernetes:

```bash
kubectl create namespace argo-example


```

Luego puedes configurar la app desde la web de ArgoCD.

---

### Gestionar un Password con Bitnami Sealed Secrets + Argo CD

#### 📌 Requisitos

- Cluster Kubernetes en ejecución (Minikube/Kind/EKS/GKE, etc.)
- Argo CD instalado y apuntando a tu repo Git
- `kubectl` configurado
- **`kubeseal` CLI instalado** (ejecutar `kubeseal.sh`)

#### Pasos

1. Sella el secreto usando kubeseal:
   ```bash
   kubeseal --controller-namespace kube-system \
     --format yaml < database-password.yaml > database-password-sealed.yaml
   ```
2. Elimina el archivo original:
   ```bash
   rm database-password.yaml
   ```
3. Sube el archivo `database-password-sealed.yaml` a tu repositorio Git.
4. Verifica el secreto creado en Kubernetes:
   ```bash
   kubectl get secret database-password -n default
   
   ```


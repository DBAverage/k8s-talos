# Kubernetes - Infrastructure As Code

This repo is intented for my own personal use controlling the kubernetes setup in my home lab environment. If you come accross this repo, be aware that it's configuration will be highly dependant on my internal environment.


# Kubernetes Installation
- Platform9 nodes due to light system requirements
- Installed on VMWare
- 1 master node
- 2 worker nodes


# Persistence Layer
- NFS subdir external provisioner
- https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git
- NFS being served by synology NAS


# Load Balancing
- MetalLB
- https://github.com/metallb/metallb.git


# Ingress - Reverse Proxy
- Traefik
- https://github.com/traefik/traefik.git


# Infrastructure As Code
- Flux
- https://github.com/fluxcd/flux2.git


# Pre-Requisites / External Dependencies
- Kubernetes cluster
- NAS Server


# Useful Commands
- Get helm chart values

        helm show values $chart_name --repo $repo_url

- tail flux logs

        flux logs -A --follow

- get pod logs

        kubectl logs -n $namespace $pod

- Describe HelmRelease to see errors

        kubectl describe helmrelease $release_name -n $namespace

- Open shell on container

        kubectl exec -it -n $namespace $container -- /bin/sh

- Check PerstistantVolumeClaims

        kubectl get persistentvolumeclaims -n $namespace

- Get Helm chart values

        helm show values $repo/$chart > $file

- Reconcile kustomization immediately

        flux reconcile ks flux-system --with-source       

- Trace kustomization

        flux trace kustomization $kustomization

- Get Status of all kustomizations

        kubectl get kustomizations  -A

- Force recreation of helmrelease

        flux suspend helmrelease -n $namespace $release
        flux resume helmrelease -n $namespace $release

# To add a new helm release
- create subfolder for namespace
- create HelmRepository CRD definition
- create HelmRelease CRD definition; including values
- commit and push to origin
- validate installation


# Get kubeseal encryption key

        kubeseal --fetch-cert \
        --controller-name sealed-secrets-controller \
        --controller-namespace sealed-secrets \
        > $certificate_output_path.pem


# Generate a kubeseal secret
- create a plaintext secret yaml 

        kubectl -n $namespace create secret generic $secret_name \
        --from-literal=$secret_key=$secret_value \
        --dry-run=client \
        -o yaml > $file_name.yaml

- encrypt secret yaml

        kubeseal --format yaml --cert pub-sealed-secrets.pem \
        --secret-file $file_name.yaml --sealed-secret-file $(file_name)-sealed.yaml

- delete insecure secret file

        rm discord-url.yaml

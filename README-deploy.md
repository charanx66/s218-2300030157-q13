Event Management System — Deployment notes

This folder contains Dockerfiles, a Helm chart and a GitHub Actions pipeline to build and deploy the Event Management System (React frontend + Spring Boot backend + Postgres).

Quick checklist before using:
- Set GitHub secrets: REGISTRY, REGISTRY_HOST, REGISTRY_USERNAME, REGISTRY_PASSWORD, KUBECONFIG (base64 or raw kubeconfig) on the repo.
- Update infra/helm/event-app/values.yaml to set image.registry and ingress.host.

Local build (PowerShell):

Set the registry environment variable, for example:
    $env:REGISTRY = "myregistry.example.com/myteam"

Build backend and push:
    docker build -t $env:REGISTRY/event-backend:local -f infra/docker/backend/Dockerfile .
    docker push $env:REGISTRY/event-backend:local

Build frontend and push:
    docker build -t $env:REGISTRY/event-frontend:local -f infra/docker/frontend/Dockerfile .
    docker push $env:REGISTRY/event-frontend:local

Deploy with Helm (requires kubectl configured):

    helm upgrade --install event-app infra/helm/event-app `
      --set image.registry=$env:REGISTRY `
      --set image.backend.repository=event-backend `
      --set image.backend.tag=local `
      --set image.frontend.repository=event-frontend `
      --set image.frontend.tag=local

Verify:
    kubectl get pods,svc,sts,hpa -o wide

Notes and next steps:
- I created a simple Postgres StatefulSet; for production use switch to managed DB or a production-grade Helm chart (Bitnami/postgresql) and backups.
- Add cert-manager if you want ACME TLS automatically.
- If you want, I can add Prometheus ServiceMonitor, RBAC, PodDisruptionBudget and SLOs.

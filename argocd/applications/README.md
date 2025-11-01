# Example Argo CD Applications

This directory contains example Argo CD Application manifests for the demo app across different environments.

## Applications

- `demo-app-dev.yaml` - Development environment application
- `demo-app-staging.yaml` - Staging environment application  
- `demo-app-prod.yaml` - Production environment application

## Usage

Before applying these applications:

1. **Update the repository URL** in each application manifest:
   ```yaml
   spec:
     source:
       repoURL: https://github.com/yourusername/your-repo.git
   ```

2. **Register target clusters** with Argo CD (if deploying to separate clusters):
   ```bash
   # Get kubeconfig context for dev cluster
   argocd cluster add kind-dev --name dev
   
   # Get kubeconfig context for staging cluster
   argocd cluster add kind-staging --name staging
   
   # Get kubeconfig context for prod cluster
   argocd cluster add kind-prod --name prod
   ```

3. **Update destination servers** in the application manifests:
   ```yaml
   spec:
     destination:
       server: https://kubernetes.default.svc  # Or cluster URL from step 2
   ```

4. **Apply the applications**:
   ```bash
   kubectl apply -f argocd/applications/demo-app-dev.yaml
   kubectl apply -f argocd/applications/demo-app-staging.yaml
   kubectl apply -f argocd/applications/demo-app-prod.yaml
   ```

## Sync Policies

- **Dev**: Auto-sync enabled with self-heal
- **Staging**: Auto-sync enabled with self-heal
- **Prod**: Manual sync (requires approval)

## Viewing Applications

```bash
# List all applications
argocd app list

# Get specific application details
argocd app get demo-app-dev

# Sync an application manually
argocd app sync demo-app-staging
```

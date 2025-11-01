# Kargo Configuration

This directory contains Kargo project, warehouse, and stage definitions for progressive delivery.

## Files

- `project.yaml` - Kargo project definition with promotion policies
- `warehouse.yaml` - Image subscription and discovery configuration
- `stages/` - Stage definitions for each environment

## Setup Instructions

1. **Update repository URLs** in all stage files:
   ```yaml
   spec:
     promotionMechanisms:
       gitRepoUpdates:
       - repoURL: https://github.com/yourusername/your-repo.git
   ```

2. **Create the Kargo project and warehouse**:
   ```bash
   kubectl apply -f kargo/project.yaml
   kubectl apply -f kargo/warehouse.yaml
   ```

3. **Create the stages**:
   ```bash
   kubectl apply -f kargo/stages/dev.yaml
   kubectl apply -f kargo/stages/staging.yaml
   kubectl apply -f kargo/stages/prod.yaml
   ```

## Promotion Flow

```
Warehouse (nginxdemos/hello:latest)
    ↓ (auto-promote)
  Dev Stage
    ↓ (manual promote)
Staging Stage
    ↓ (manual promote with verification)
  Prod Stage
```

## Promotion Policies

- **Dev**: Auto-promotion enabled
- **Staging**: Manual promotion required
- **Prod**: Manual promotion with verification required

## Working with Kargo

```bash
# List all projects
kargo get projects

# List stages in demo-app project
kargo get stages -n demo-app

# View freight (available versions)
kargo get freight -n demo-app

# Promote to staging
kargo promote --project demo-app --stage staging

# Promote to prod
kargo promote --project demo-app --stage prod

# Check promotion status
kargo get promotions -n demo-app
```

## Warehouse Subscriptions

The warehouse is configured to watch for new images:
- Repository: `nginxdemos/hello`
- Version constraint: `^0.3.0`
- Discovery limit: 5 most recent images

When new images matching the constraint are published, Kargo will:
1. Detect the new version
2. Auto-promote to dev (if enabled)
3. Wait for manual promotion to staging
4. Wait for manual promotion to prod

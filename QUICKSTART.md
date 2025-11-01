# Quick Start Guide

This guide will get you up and running with the Argo CD and Kargo multi-cluster lab in minutes.

## Prerequisites

✅ Docker Desktop installed and running  
✅ VS Code with Dev Containers extension  
✅ At least 8GB RAM available  
✅ 20GB free disk space  

## Step-by-Step Setup

### 1. Open in DevContainer

```bash
# Clone the repository
git clone https://github.com/c-yco/argo-kargo-multicluster-lab.git
cd argo-kargo-multicluster-lab

# Open in VS Code
code .
```

When prompted, click **"Reopen in Container"**

### 2. Complete Setup (One Command)

```bash
task setup
```

This single command will:
- ✅ Create 1 control plane cluster (management) with 2 worker nodes
- ✅ Create 3 worker clusters (dev, staging, prod)
- ✅ Install Argo CD on the management cluster
- ✅ Install Kargo on the management cluster

**Time:** ~5-10 minutes

### 3. Access the UIs

**Argo CD:**
```bash
# Terminal 1: Get password
task argocd:password

# Terminal 2: Port forward
task argocd:port-forward

# Open: https://localhost:8080
# Username: admin
# Password: (from terminal 1)
```

**Kargo:**
```bash
# Terminal 3: Port forward
task kargo:port-forward

# Open: http://localhost:9090
```

### 4. Register Worker Clusters with Argo CD

```bash
# Login to Argo CD CLI
task argocd:login

# Register worker clusters
task argocd:register-clusters
```

### 5. Deploy Demo Applications

```bash
task argocd:apps:deploy
```

### 6. Configure Kargo

```bash
task kargo:apply
```

## What's Running?

After setup, you'll have:

### Management Cluster (kind-management)
- Argo CD control plane
- Kargo control plane
- 1 control-plane node + 2 worker nodes

### Worker Clusters
- **kind-dev**: Development environment
- **kind-staging**: Staging environment
- **kind-prod**: Production environment

## Next Steps

### Explore Argo CD
```bash
# List applications
task argocd:apps:list

# Or use the UI at https://localhost:8080
```

### Explore Kargo
```bash
# Check status
task kargo:status

# Or use the UI at http://localhost:9090
```

### Monitor Health
```bash
task health
```

### View Logs
```bash
# Argo CD logs
task logs:argocd

# Kargo logs
task logs:kargo
```

## Common Commands

```bash
# List all tasks
task

# Check system health
task health

# Switch clusters
task clusters:switch

# Validate manifests
task validate

# Clean up everything
task clean

# Reset and rebuild
task reset
```

## Troubleshooting

### Port Already in Use
If ports 8080, 8443, or 9090 are already in use, stop the conflicting service or modify the port mappings in `.devcontainer/devcontainer.json`

### Cluster Creation Fails
```bash
# Clean up and retry
task clean
task clusters:create
```

### Can't Access UI
```bash
# Check if port forwarding is running
ps aux | grep port-forward

# Restart port forward
task argocd:port-forward
# or
task kargo:port-forward
```

### Out of Memory
Ensure Docker Desktop has at least 8GB RAM allocated in Docker Desktop Settings → Resources

## Learning Resources

- Check out the example manifests in `manifests/`
- Review Argo CD applications in `argocd/applications/`
- Explore Kargo configuration in `kargo/`
- Read the main [README.md](README.md) for detailed documentation

## Quick Clean Up

```bash
# Delete all clusters
task clean

# Or delete individual clusters
kind delete cluster --name management
kind delete cluster --name dev
kind delete cluster --name staging
kind delete cluster --name prod
```

---

🎉 **You're all set!** Start exploring GitOps with Argo CD and progressive delivery with Kargo!

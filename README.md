# Argo CD, Kargo & Kind Multi-Cluster Lab

A complete development environment for learning and experimenting with Argo CD, Kargo, and Kubernetes multi-cluster deployments using Kind (Kubernetes in Docker).

> 🚀 **New here?** Check out the [Quick Start Guide](QUICKSTART.md) to get up and running in minutes!

## 🚀 Features

- **DevContainer Support**: Fully configured development container with all necessary tools
- **Docker-outside-Docker**: Access to host Docker daemon for Kind cluster management
- **Taskfile Automation**: All operations managed through simple task commands
- **Pre-configured Tools**:
  - `task` - Task runner for automation
  - `kubectl` - Kubernetes CLI
  - `kind` - Kubernetes in Docker
  - `helm` - Kubernetes package manager
  - `argocd` - Argo CD CLI
  - `kargo` - Kargo CLI
  - `docker` - Docker CLI
- **Multi-cluster Setup**: One control plane cluster with 3 worker clusters (dev, staging, prod)
- **GitOps Ready**: Example Argo CD applications and Kargo projects

## 📋 Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your host machine
- [Visual Studio Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- At least 8GB RAM available for Docker
- 20GB free disk space

## 🏁 Getting Started

### 1. Open in DevContainer

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd argo-kargo-multicluster-lab
   ```

2. Open in VS Code:
   ```bash
   code .
   ```

3. When prompted, click **"Reopen in Container"** or press `F1` and select **"Dev Containers: Reopen in Container"**

4. Wait for the container to build and initialize (first time may take a few minutes)

### 2. Create Kind Clusters

Once inside the devcontainer, view available tasks:

```bash
task
```

Create the complete multi-cluster environment:

```bash
task setup
```

This will:
1. Create one **management** control plane cluster (with 2 worker nodes)
2. Create three worker clusters: **dev**, **staging**, **prod**
3. Install Argo CD on the management cluster
4. Install Kargo on the management cluster

Or run individual steps:

```bash
# Just create clusters
task clusters:create

# Just install Argo CD
task argocd:install

# Just install Kargo
task kargo:install
```

### 3. Access Argo CD

Get the admin password and access the UI:

```bash
# Get admin password
task argocd:password

# Port forward to access UI (in a separate terminal)
task argocd:port-forward
```

Access Argo CD UI at: `https://localhost:8080`
- Username: `admin`
- Password: (from command above)

### 4. Access Kargo

Access Kargo UI:

```bash
# Port forward to access UI
task kargo:port-forward
```

Access Kargo UI at: `http://localhost:9090`

## 📁 Project Structure

```
.
├── .devcontainer/          # DevContainer configuration
│   ├── devcontainer.json   # Container setup
│   └── post-create.sh      # Post-creation script
├── .github/                # GitHub configuration
│   └── copilot-instructions.md
├── Taskfile.yml            # Task automation definitions
├── scripts/                # Legacy utility scripts (use tasks instead)
│   ├── setup-clusters.sh   # Create Kind clusters
│   ├── install-argocd.sh   # Install Argo CD
│   ├── install-kargo.sh    # Install Kargo
│   └── cleanup.sh          # Delete all clusters
├── argocd/                 # Argo CD applications
│   └── applications/       # Application manifests
├── kargo/                  # Kargo resources
│   ├── project.yaml        # Kargo project definition
│   ├── stages/             # Stage definitions
│   └── warehouse.yaml      # Warehouse configuration
└── manifests/              # Kubernetes manifests
    ├── base/               # Base configurations
    └── overlays/           # Environment-specific overlays
```

## 🛠️ Common Tasks

### Available Tasks

View all available tasks:

```bash
task
# or
task --list
```

### Cluster Management

```bash
# Create all clusters (1 control plane + 3 workers)
task clusters:create

# List all clusters
task clusters:list

# List kubectl contexts
task clusters:contexts

# Switch between clusters interactively
task clusters:switch

# Delete all clusters
task clusters:delete
```

### Argo CD Operations

```bash
# Install Argo CD
task argocd:install

# Get admin password
task argocd:password

# Port forward UI
task argocd:port-forward

# Login via CLI
task argocd:login

# Register worker clusters
task argocd:register-clusters

# List applications
task argocd:apps:list

# Deploy demo applications
task argocd:apps:deploy

# View logs
task logs:argocd
```

### Kargo Operations

```bash
# Install Kargo
task kargo:install

# Port forward UI
task kargo:port-forward

# Apply Kargo resources
task kargo:apply

# Check status
task kargo:status

# View logs
task logs:kargo
```

### Development

```bash
# Validate all manifests
task validate

# Run full development workflow
task dev

# Check system health
task health
```

### Kubectl Context Management

### Kubectl Context Management

```bash
# List all contexts
kubectl config get-contexts

# Switch to a specific cluster
kubectl config use-context kind-management
kubectl config use-context kind-dev
kubectl config use-context kind-staging
kubectl config use-context kind-prod

# Or use task for interactive switching
task clusters:switch
```

### Deploy Application with Argo CD

```bash
# Using tasks
task argocd:apps:deploy

# Or manually
kubectl apply -f argocd/applications/demo-app-dev.yaml
argocd app sync demo-app-dev
argocd app get demo-app-dev
```

### Work with Kargo

```bash
# Apply all Kargo resources
task kargo:apply

# Check status
task kargo:status

# Or use kargo CLI directly
kargo get projects
kargo get stages -n demo-app
kargo get freight -n demo-app
kargo promote --project demo-app --stage staging
```

### View Logs

```bash
# Argo CD logs
task logs:argocd

# Kargo logs
task logs:kargo

# Or use kubectl directly
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server -f
kubectl logs -n kargo -l app.kubernetes.io/name=kargo-controller -f
```

## 🧹 Cleanup

To remove all Kind clusters:

```bash
task clusters:delete
# or
task clean
```

To reset everything (delete and recreate):

```bash
task reset
```

## 🔧 Helpful Aliases

The devcontainer comes with pre-configured aliases:

### Kubernetes
- `k` - kubectl
- `kgp` - kubectl get pods
- `kgs` - kubectl get services
- `kgd` - kubectl get deployments
- `kga` - kubectl get all
- `kaf` - kubectl apply -f
- `kdf` - kubectl delete -f

### Kind
- `kind-create` - kind create cluster
- `kind-delete` - kind delete cluster
- `kind-list` - kind get clusters

### Argo CD
- `argocd-apps` - argocd app list
- `argocd-sync` - argocd app sync

### Kargo
- `kargo-projects` - kargo get projects
- `kargo-stages` - kargo get stages
- `kargo-promotions` - kargo get promotions

## 📝 Quick Reference

### Common Task Commands

| Command | Description |
|---------|-------------|
| `task` | List all available tasks |
| `task setup` | Complete setup (clusters + Argo CD + Kargo) |
| `task clusters:create` | Create all Kind clusters |
| `task argocd:install` | Install Argo CD |
| `task kargo:install` | Install Kargo |
| `task health` | Check system health |
| `task validate` | Validate Kubernetes manifests |
| `task clean` | Delete all clusters |

### Cluster Architecture

- **management** (Control Plane)
  - 1 control-plane node
  - 2 worker nodes
  - Hosts Argo CD and Kargo
  - Port mappings: 8080 (HTTP), 8443 (HTTPS)
  
- **dev** (Worker Cluster)
  - Development environment
  
- **staging** (Worker Cluster)
  - Staging environment
  
- **prod** (Worker Cluster)
  - Production environment

## 📚 Resources

- [Argo CD Documentation](https://argo-cd.readthedocs.io/)
- [Kargo Documentation](https://kargo.akuity.io/)
- [Kind Documentation](https://kind.sigs.k8s.io/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

## 🤝 Contributing

Feel free to open issues or submit pull requests for improvements!

## 📄 License

This project is provided as-is for educational purposes.

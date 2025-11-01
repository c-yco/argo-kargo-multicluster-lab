# Argo CD, Kargo, and Kind Devcontainer Workspace

## Project Overview
This is a devcontainer-based development environment for working with Argo CD, Kargo, and Kubernetes using Kind (Kubernetes in Docker). The workspace uses Docker-outside-Docker to connect to the host Docker daemon and Taskfile for automation.

## Tools Included
- task: Task runner for automation
- kubectl: Kubernetes CLI
- kind: Kubernetes in Docker
- helm: Kubernetes package manager
- Argo CD CLI: GitOps continuous delivery tool
- Kargo CLI: Advanced Kubernetes deployment tool
- Docker CLI: Container management

## Development Guidelines
- Use Taskfile (`task`) for all operations - avoid running scripts directly
- Use the devcontainer for all Kubernetes operations
- Docker commands connect to the host Docker daemon
- Kind clusters are created on the host Docker
- Follow GitOps principles with Argo CD
- Use Kargo for multi-cluster deployments

## Cluster Architecture
- 1 control plane cluster (management) with 2 worker nodes
- 3 worker clusters (dev, staging, prod)
- Management cluster hosts Argo CD and Kargo

## Project Structure
- `.devcontainer/`: Development container configuration
- `Taskfile.yml`: Task automation definitions
- `scripts/`: Legacy scripts (use tasks instead)
- `manifests/`: Kubernetes manifests and examples
- `argocd/`: Argo CD application definitions
- `kargo/`: Kargo project and stage definitions

## Common Commands
- `task` - List all available tasks
- `task setup` - Complete setup (clusters + Argo CD + Kargo)
- `task health` - Check system health
- `task clean` - Delete all clusters

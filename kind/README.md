# Kind Cluster Configurations

This directory contains Kind (Kubernetes in Docker) cluster configuration files for the multi-cluster lab environment.

## Cluster Configurations

### management-cluster.yaml
The control plane cluster configuration with:
- 1 control plane node
- 2 worker nodes (worker-1, worker-2)
- Ingress support with port mappings (8080:80, 8443:443)
- Hosts Argo CD and Kargo

### worker-cluster.yaml
Template for worker clusters (dev, staging, prod):
- 1 control plane node
- Single-node clusters for application deployments

## Docker-outside-of-Docker Configuration

All clusters are configured with:
- `apiServerAddress: "0.0.0.0"` - Bind to all interfaces
- Certificate SANs including `host.docker.internal` - For devcontainer access
- Proper TLS certificates for secure connections from the dev container

## Usage

Clusters are created via the Taskfile:
```bash
# Create all clusters
task clusters:create

# Delete all clusters
task clusters:delete
```

The configurations ensure proper networking when using Docker-outside-of-Docker in the devcontainer environment.

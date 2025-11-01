#!/bin/bash
set -e

echo "🏗️  Creating Kind clusters for multi-cluster setup..."

# Create management cluster
echo "📍 Creating management cluster..."
cat <<EOF | kind create cluster --name management --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 8080
    protocol: TCP
  - containerPort: 443
    hostPort: 8443
    protocol: TCP
EOF

# Create dev cluster
echo "📍 Creating dev cluster..."
kind create cluster --name dev

# Create staging cluster
echo "📍 Creating staging cluster..."
kind create cluster --name staging

# Create production cluster
echo "📍 Creating production cluster..."
kind create cluster --name prod

# List all clusters
echo ""
echo "✅ Clusters created successfully!"
echo "-----------------------------------"
kind get clusters
echo ""

# Set context to management cluster
kubectl config use-context kind-management

echo "🎯 Current context set to: kind-management"
echo ""
echo "💡 Next steps:"
echo "  1. Run 'bash scripts/install-argocd.sh' to install Argo CD"
echo "  2. Run 'bash scripts/install-kargo.sh' to install Kargo"

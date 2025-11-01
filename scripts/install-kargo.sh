#!/bin/bash
set -e

echo "📦 Installing Kargo on management cluster..."

# Switch to management cluster
kubectl config use-context kind-management

# Add Kargo Helm repository
echo "📚 Adding Kargo Helm repository..."
helm repo add kargo https://charts.kargo.io
helm repo update

# Create kargo namespace
echo "📦 Creating kargo namespace..."
kubectl create namespace kargo || echo "Namespace already exists"

# Install Kargo
echo "📥 Installing Kargo..."
helm install kargo kargo/kargo \
  --namespace kargo \
  --create-namespace \
  --wait \
  --timeout=5m

# Wait for Kargo to be ready
echo "⏳ Waiting for Kargo to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/kargo-controller -n kargo || true
kubectl wait --for=condition=available --timeout=300s deployment/kargo-api -n kargo || true

echo ""
echo "✅ Kargo installed successfully!"
echo "-----------------------------------"
echo "🌐 Access Kargo UI:"
echo "  Port forward: kubectl port-forward svc/kargo-api -n kargo 9090:80"
echo "  URL: http://localhost:9090"
echo ""
echo "💡 Next steps:"
echo "  1. Create a Kargo project: kubectl apply -f kargo/project.yaml"
echo "  2. Define stages: kubectl apply -f kargo/stages/"
echo "  3. Set up promotions: kubectl apply -f kargo/promotions/"

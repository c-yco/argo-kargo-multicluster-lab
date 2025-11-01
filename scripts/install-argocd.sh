#!/bin/bash
set -e

echo "🔄 Installing Argo CD on management cluster..."

# Switch to management cluster
kubectl config use-context kind-management

# Create argocd namespace
echo "📦 Creating argocd namespace..."
kubectl create namespace argocd || echo "Namespace already exists"

# Install Argo CD
echo "📥 Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be ready
echo "⏳ Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Patch argocd-server service to use NodePort
echo "🔧 Configuring Argo CD service..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Get initial admin password
echo ""
echo "✅ Argo CD installed successfully!"
echo "-----------------------------------"
echo "🔑 Initial admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo ""
echo ""
echo "🌐 Access Argo CD UI:"
echo "  Username: admin"
echo "  Port forward: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "  URL: https://localhost:8080"
echo ""
echo "🔐 Login via CLI:"
echo "  argocd login localhost:8080 --username admin --password <password-above> --insecure"

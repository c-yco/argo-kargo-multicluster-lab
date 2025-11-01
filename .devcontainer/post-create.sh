#!/bin/bash
set -e

echo "🚀 Setting up Argo CD, Kargo, and Kind development environment..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update

# Install required dependencies
echo "📦 Installing dependencies..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    jq \
    vim \
    bash-completion

# Install Taskfile
echo "📋 Installing Taskfile..."
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Install kind
echo "🐳 Installing Kind..."
KIND_VERSION="v0.20.0"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install Argo CD CLI
echo "🔄 Installing Argo CD CLI..."
ARGOCD_VERSION=$(curl -s https://api.github.com/repos/argoproj/argo-cd/releases/latest | jq -r .tag_name)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Install Kargo CLI
echo "📦 Installing Kargo CLI..."
KARGO_VERSION=$(curl -s https://api.github.com/repos/akuity/kargo/releases/latest | jq -r .tag_name)
curl -sSL -o kargo-linux-amd64 https://github.com/akuity/kargo/releases/download/${KARGO_VERSION}/kargo-linux-amd64
sudo install -m 555 kargo-linux-amd64 /usr/local/bin/kargo
rm kargo-linux-amd64

# Setup kubectl completion
echo "⚙️  Setting up shell completions..."
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
kind completion bash | sudo tee /etc/bash_completion.d/kind > /dev/null

# Add aliases
echo "⚙️  Adding helpful aliases..."
cat >> ~/.bashrc << 'EOF'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kga='kubectl get all'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias kx='kubectl exec -it'

# Kind aliases
alias kind-create='kind create cluster'
alias kind-delete='kind delete cluster'
alias kind-list='kind get clusters'

# Argo CD aliases
alias argocd-login='argocd login'
alias argocd-apps='argocd app list'
alias argocd-sync='argocd app sync'

# Kargo aliases
alias kargo-projects='kargo get projects'
alias kargo-stages='kargo get stages'
alias kargo-promotions='kargo get promotions'

EOF

# Setup task completion
echo "⚙️  Setting up task completions..."
task --completion bash | sudo tee /etc/bash_completion.d/task > /dev/null

# Verify installations
echo ""
echo "✅ Installation complete! Versions:"
echo "-----------------------------------"
echo "kubectl: $(kubectl version --client --short 2>/dev/null || echo 'installed')"
echo "helm: $(helm version --short 2>/dev/null || echo 'installed')"
echo "kind: $(kind version 2>/dev/null || echo 'installed')"
echo "docker: $(docker --version)"
echo "argocd: $(argocd version --client --short 2>/dev/null || echo 'installed')"
echo "kargo: $(kargo version 2>/dev/null || echo 'installed')"
echo "task: $(task --version)"
echo ""
echo "🎉 Development environment is ready!"
echo ""
echo "💡 Quick Start:"
echo "  1. Run 'task' to see all available tasks"
echo "  2. Run 'task setup' to create clusters and install tools"
echo "  3. Run 'task health' to check system status"

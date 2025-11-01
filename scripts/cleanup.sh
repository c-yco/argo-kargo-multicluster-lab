#!/bin/bash
set -e

echo "🗑️  Cleaning up all Kind clusters..."

# Get all kind clusters
CLUSTERS=$(kind get clusters 2>/dev/null || echo "")

if [ -z "$CLUSTERS" ]; then
    echo "ℹ️  No Kind clusters found."
    exit 0
fi

# Delete each cluster
for cluster in $CLUSTERS; do
    echo "🗑️  Deleting cluster: $cluster"
    kind delete cluster --name "$cluster"
done

echo ""
echo "✅ All Kind clusters deleted successfully!"

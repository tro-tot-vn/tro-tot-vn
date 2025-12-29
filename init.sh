#!/bin/bash

# Script to clone/pull all TroTotVN services
# Run from the root directory of tro-tot-vn

set -e

REPOS=(
    "git@github.com:tro-tot-vn/recommend-service.git"
    "git@github.com:tro-tot-vn/search-service.git"
    "git@github.com:tro-tot-vn/sync-service.git"
    "git@github.com:tro-tot-vn/tro-tot-vn-fe.git"
    "git@github.com:tro-tot-vn/tro-tot-vn-be.git"
)

echo "=== TroTotVN Services Initialization ==="
echo ""

for repo in "${REPOS[@]}"; do
    # Extract folder name from repo URL
    folder=$(basename "$repo" .git)
    
    if [ -d "$folder" ]; then
        echo "📂 $folder exists, pulling latest changes..."
        cd "$folder"
        git pull
        cd ..
    else
        echo "📥 Cloning $folder..."
        git clone "$repo"
    fi
    echo ""
done

echo "✅ All services initialized successfully!"

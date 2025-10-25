#!/bin/bash

# Quick start script for sync-service

echo "🚀 Starting Tro Tot VN with Sync Service..."
echo ""

# Check if docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Navigate to compose directory
cd "$(dirname "$0")/infras/compose"

# Start all services
echo "📦 Starting Docker services..."
docker compose -f docker-compose.dev.yaml up -d

echo ""
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service status
echo ""
echo "📊 Service Status:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
docker compose -f docker-compose.dev.yaml ps

echo ""
echo "📝 Check sync-service logs:"
echo "docker logs -f sync-service"
echo ""
echo "🔍 Check Milvus collections:"
echo "docker exec -it sync-service python -c 'from pymilvus import connections, utility; connections.connect(host=\"milvus-standalone\", port=\"19530\"); print(utility.list_collections())'"
echo ""
echo "✅ All services started!"
echo ""
echo "🌐 Access URLs:"
echo "  - Redis Insight: http://localhost:5540"
echo "  - Minio Console: http://localhost:9001 (admin/minioadmin)"
echo "  - Milvus: localhost:19530"
echo ""



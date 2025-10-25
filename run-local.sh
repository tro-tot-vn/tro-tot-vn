#!/bin/bash

# ============================================
# 🚀 Tro Tot VN - Local Development Startup Script
# ============================================
# Chạy tất cả services: Docker + Backend + Frontend
# ============================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ============================================
# Helper Functions
# ============================================

print_header() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

check_command() {
    if ! command -v $1 &> /dev/null; then
        print_error "$1 không được cài đặt. Vui lòng cài đặt $1 trước."
        exit 1
    fi
}

# ============================================
# Pre-flight Checks
# ============================================

print_header "🔍 Kiểm tra môi trường"

# Check Docker
check_command docker
if ! docker info > /dev/null 2>&1; then
    print_error "Docker không chạy. Vui lòng khởi động Docker Desktop."
    exit 1
fi
print_success "Docker đang chạy"

# Check Node.js
check_command node
NODE_VERSION=$(node --version)
print_success "Node.js ${NODE_VERSION}"

# Check npm
check_command npm
NPM_VERSION=$(npm --version)
print_success "npm ${NPM_VERSION}"

# ============================================
# Start Docker Services
# ============================================

print_header "🐳 Khởi động Docker Services"

cd "$SCRIPT_DIR/infras/compose"

print_info "Dừng các container cũ (nếu có)..."
docker compose -f docker-compose.dev.yaml down 2>/dev/null || true

print_info "Khởi động Docker Compose services..."
docker compose -f docker-compose.dev.yaml up -d --build

print_info "Chờ services khởi động hoàn tất..."
sleep 15

# Check Docker services status
echo ""
print_info "Trạng thái Docker containers:"
docker compose -f docker-compose.dev.yaml ps

# ============================================
# Check Backend Dependencies
# ============================================

print_header "📦 Kiểm tra Backend Dependencies"

cd "$SCRIPT_DIR/tro-tot-vn-be"

if [ ! -d "node_modules" ]; then
    print_warning "node_modules không tồn tại. Đang cài đặt dependencies..."
    npm install
    print_success "Đã cài đặt backend dependencies"
else
    print_success "Backend dependencies đã có sẵn"
fi

# ============================================
# Check Frontend Dependencies
# ============================================

print_header "📦 Kiểm tra Frontend Dependencies"

cd "$SCRIPT_DIR/tro-tot-vn-fe"

if [ ! -d "node_modules" ]; then
    print_warning "node_modules không tồn tại. Đang cài đặt dependencies..."
    npm install
    print_success "Đã cài đặt frontend dependencies"
else
    print_success "Frontend dependencies đã có sẵn"
fi

# ============================================
# Start Backend Service
# ============================================

print_header "🔧 Khởi động Backend Service"

cd "$SCRIPT_DIR/tro-tot-vn-be"

# Kill existing backend process if any
pkill -f "nodemon app.ts" 2>/dev/null || true
pkill -f "ts-node.*app.ts" 2>/dev/null || true

print_info "Đang khởi động backend (nodemon)..."
nohup npm run dev > "$SCRIPT_DIR/logs/backend.log" 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > "$SCRIPT_DIR/logs/backend.pid"

sleep 3

if ps -p $BACKEND_PID > /dev/null; then
    print_success "Backend đang chạy (PID: $BACKEND_PID)"
else
    print_error "Backend không khởi động được. Kiểm tra logs/backend.log"
    exit 1
fi

# ============================================
# Start Frontend Service
# ============================================

print_header "🎨 Khởi động Frontend Service"

cd "$SCRIPT_DIR/tro-tot-vn-fe"

# Kill existing frontend process if any
pkill -f "vite" 2>/dev/null || true

print_info "Đang khởi động frontend (Vite)..."
nohup npm run dev > "$SCRIPT_DIR/logs/frontend.log" 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > "$SCRIPT_DIR/logs/frontend.pid"

sleep 3

if ps -p $FRONTEND_PID > /dev/null; then
    print_success "Frontend đang chạy (PID: $FRONTEND_PID)"
else
    print_error "Frontend không khởi động được. Kiểm tra logs/frontend.log"
    exit 1
fi

# ============================================
# Summary
# ============================================

print_header "✨ TẤT CẢ SERVICES ĐÃ KHỞI ĐỘNG!"

echo ""
echo -e "${GREEN}🌐 Access URLs:${NC}"
echo -e "  ${CYAN}Frontend:${NC}         http://localhost:5173"
echo -e "  ${CYAN}Backend:${NC}          http://localhost:3000"
echo -e "  ${CYAN}Redis Insight:${NC}    http://localhost:5540"
echo -e "  ${CYAN}Minio Console:${NC}    http://localhost:9001 (admin/minioadmin)"
echo ""

echo -e "${YELLOW}📝 Logs:${NC}"
echo -e "  ${CYAN}Backend:${NC}   tail -f logs/backend.log"
echo -e "  ${CYAN}Frontend:${NC}  tail -f logs/frontend.log"
echo -e "  ${CYAN}Sync:${NC}      docker logs -f sync-service"
echo ""

echo -e "${YELLOW}🛑 Để dừng tất cả services:${NC}"
echo -e "  ${CYAN}./stop-local.sh${NC}"
echo ""

echo -e "${YELLOW}📊 Kiểm tra trạng thái:${NC}"
echo -e "  ${CYAN}ps aux | grep -E 'nodemon|vite'${NC}"
echo -e "  ${CYAN}docker compose -f infras/compose/docker-compose.dev.yaml ps${NC}"
echo ""

print_success "Hệ thống đã sẵn sàng phát triển! 🚀"
echo ""
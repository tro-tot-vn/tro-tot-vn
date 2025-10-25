#!/bin/bash

# ============================================
# 🛑 Tro Tot VN - Stop All Local Services
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

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

print_info() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

print_header "🛑 Đang dừng tất cả services..."

# ============================================
# Stop Backend
# ============================================

echo -e "${YELLOW}📦 Dừng Backend Service...${NC}"

if [ -f "$SCRIPT_DIR/logs/backend.pid" ]; then
    BACKEND_PID=$(cat "$SCRIPT_DIR/logs/backend.pid")
    if ps -p $BACKEND_PID > /dev/null 2>&1; then
        kill $BACKEND_PID 2>/dev/null || true
        print_success "Backend đã dừng (PID: $BACKEND_PID)"
    else
        print_info "Backend không chạy"
    fi
    rm -f "$SCRIPT_DIR/logs/backend.pid"
else
    # Try to kill by process name
    pkill -f "nodemon app.ts" 2>/dev/null && print_success "Backend đã dừng" || print_info "Backend không chạy"
    pkill -f "ts-node.*app.ts" 2>/dev/null || true
fi

# ============================================
# Stop Frontend
# ============================================

echo ""
echo -e "${YELLOW}🎨 Dừng Frontend Service...${NC}"

if [ -f "$SCRIPT_DIR/logs/frontend.pid" ]; then
    FRONTEND_PID=$(cat "$SCRIPT_DIR/logs/frontend.pid")
    if ps -p $FRONTEND_PID > /dev/null 2>&1; then
        kill $FRONTEND_PID 2>/dev/null || true
        print_success "Frontend đã dừng (PID: $FRONTEND_PID)"
    else
        print_info "Frontend không chạy"
    fi
    rm -f "$SCRIPT_DIR/logs/frontend.pid"
else
    # Try to kill by process name
    pkill -f "vite" 2>/dev/null && print_success "Frontend đã dừng" || print_info "Frontend không chạy"
fi

# ============================================
# Stop Docker Services
# ============================================

echo ""
echo -e "${YELLOW}🐳 Dừng Docker Services...${NC}"

cd "$SCRIPT_DIR/infras/compose"
docker compose -f docker-compose.dev.yaml down

print_success "Docker services đã dừng"

# ============================================
# Summary
# ============================================

print_header "✅ TẤT CẢ SERVICES ĐÃ DỪNG!"

echo ""
echo -e "${GREEN}💡 Để khởi động lại:${NC}"
echo -e "  ${CYAN}./run-local.sh${NC}"
echo ""


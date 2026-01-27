#!/bin/sh
set -e

# ============================================
# Hàm tiện ích
# ============================================

get_ip() {
    wget -qO- --timeout=10 http://ipv4.icanhazip.com 2>/dev/null || echo ""
}

stop_coturn() {
    if [ -n "$COTURN_PID" ] && kill -0 $COTURN_PID 2>/dev/null; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Dang dung Coturn (PID: $COTURN_PID)..."
        kill -TERM $COTURN_PID
        wait $COTURN_PID 2>/dev/null || true
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Coturn da dung"
    fi
}

# ============================================
# Signal handlers
# ============================================

trap 'stop_coturn; exit 0' TERM INT

# ============================================
# Lấy IP ban đầu
# ============================================

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Dang lay Public IP..."
CURRENT_IP=$(get_ip)

while [ -z "$CURRENT_IP" ]; do
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Khong lay duoc IP, thu lai sau 5s..."
    sleep 5
    CURRENT_IP=$(get_ip)
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Public IP: $CURRENT_IP"

# ============================================
# Tạo config file động với IP hiện tại
# ============================================

if [ -f /etc/coturn/turnserver.conf.template ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Tao config file tu template..."
    sed "s/{{EXTERNAL_IP}}/$CURRENT_IP/g" /etc/coturn/turnserver.conf.template > /etc/coturn/turnserver.conf
fi

# ============================================
# Khởi động Coturn
# ============================================

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Khoi dong Coturn server..."

if [ -f /etc/coturn/turnserver.conf ]; then
    # Chạy với config file
    turnserver -c /etc/coturn/turnserver.conf --external-ip="$CURRENT_IP" &
else
    # Chạy với command line arguments
    turnserver \
        --log-file=stdout \
        --min-port=${MIN_PORT:-49160} \
        --max-port=${MAX_PORT:-49200} \
        --listening-port=${LISTENING_PORT:-3478} \
        --lt-cred-mech \
        --fingerprint \
        --realm=${REALM:-my-video-app.com} \
        --user=${TURN_USER:-myuser}:${TURN_PASSWORD:-mypassword123} \
        --external-ip="$CURRENT_IP" &
fi

COTURN_PID=$!
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Coturn da khoi dong (PID: $COTURN_PID)"

# ============================================
# Vòng lặp giám sát IP
# ============================================

CHECK_INTERVAL=${CHECK_INTERVAL:-300}
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Bat dau giam sat IP (kiem tra moi ${CHECK_INTERVAL}s)..."

while kill -0 $COTURN_PID 2>/dev/null; do
    sleep $CHECK_INTERVAL
    
    NEW_IP=$(get_ip)
    
    if [ -z "$NEW_IP" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] CANH BAO: Khong lay duoc IP moi"
        continue
    fi
    
    if [ "$NEW_IP" != "$CURRENT_IP" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ========================================="
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHAT HIEN IP THAY DOI!"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] IP cu:  $CURRENT_IP"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] IP moi: $NEW_IP"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ========================================="
        
        stop_coturn
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart container de cap nhat IP..."
        exit 1
    fi
done

# ============================================
# Xử lý nếu Coturn tự dừng
# ============================================

echo "[$(date '+%Y-%m-%d %H:%M:%S')] LOI: Coturn da dung bat ngo!"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart container..."
exit 1
# 🚀 Quick Start Guide - Tro Tot VN

## 📋 Yêu cầu hệ thống

- Docker Desktop (đang chạy)
- Node.js >= 18.x
- npm >= 9.x

## ⚡ Khởi động nhanh

### Chạy tất cả services

```bash
./run-local.sh
```

Script này sẽ tự động:
- ✅ Kiểm tra môi trường (Docker, Node.js, npm)
- ✅ Khởi động Docker services (DB, Redis, Milvus, Sync Service)
- ✅ Cài đặt dependencies (nếu chưa có)
- ✅ Khởi động Backend (Node.js/TypeScript)
- ✅ Khởi động Frontend (Vite/React)

### Dừng tất cả services

```bash
./stop-local.sh
```

## 🌐 URLs

Sau khi chạy thành công, truy cập:

| Service | URL | Mô tả |
|---------|-----|-------|
| **Frontend** | http://localhost:5173 | Giao diện người dùng |
| **Backend** | http://localhost:3000 | API Server |
| **Redis Insight** | http://localhost:5540 | Quản lý Redis |
| **Minio Console** | http://localhost:9001 | Quản lý Minio (admin/minioadmin) |

## 📝 Xem logs

### Backend logs
```bash
tail -f logs/backend.log
```

### Frontend logs
```bash
tail -f logs/frontend.log
```

### Sync Service logs
```bash
docker logs -f sync-service
```

### Tất cả Docker services
```bash
cd infras/compose
docker compose -f docker-compose.dev.yaml logs -f
```

## 🔍 Kiểm tra trạng thái

### Kiểm tra Backend và Frontend
```bash
ps aux | grep -E 'nodemon|vite'
```

### Kiểm tra Docker services
```bash
cd infras/compose
docker compose -f docker-compose.dev.yaml ps
```

## 🐛 Troubleshooting

### Backend không khởi động

1. Kiểm tra logs:
```bash
cat logs/backend.log
```

2. Kiểm tra database connection:
```bash
docker exec -it db-trototvn /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "00hihiHIHI-" -Q "SELECT 1" -C
```

3. Kiểm tra Redis:
```bash
docker exec -it redis-trototvn redis-cli ping
```

### Frontend không khởi động

1. Kiểm tra logs:
```bash
cat logs/frontend.log
```

2. Xóa node_modules và cài lại:
```bash
cd tro-tot-vn-fe
rm -rf node_modules package-lock.json
npm install
```

### Docker services lỗi

1. Xem logs chi tiết:
```bash
cd infras/compose
docker compose -f docker-compose.dev.yaml logs
```

2. Restart Docker services:
```bash
cd infras/compose
docker compose -f docker-compose.dev.yaml down
docker compose -f docker-compose.dev.yaml up -d --build
```

### Port đã được sử dụng

Kiểm tra port đang dùng:
```bash
# Backend port 3000
lsof -i :3000

# Frontend port 5173
lsof -i :5173

# Kill process nếu cần
kill -9 <PID>
```

## 📦 Services

### Docker Services (docker-compose.dev.yaml)
- **db-trototvn**: MS SQL Server (port 1433)
- **redis-trototvn**: Redis (port 5555)
- **redis-insight-trototvn**: Redis GUI (port 5540)
- **milvus-standalone**: Vector Database (port 19530)
- **etcd**: Milvus metadata store
- **minio**: Milvus object storage (port 9000, 9001)
- **sync-service**: Python service đồng bộ data tới Milvus

### Application Services
- **Backend**: Node.js/TypeScript API (port 3000)
- **Frontend**: Vite/React SPA (port 5173)

## 🔄 Workflow phát triển

1. **Khởi động lần đầu**:
```bash
./run-local.sh
```

2. **Code và test** - Backend và Frontend sẽ tự động reload

3. **Xem logs** khi cần debug:
```bash
tail -f logs/backend.log
tail -f logs/frontend.log
```

4. **Dừng khi kết thúc**:
```bash
./stop-local.sh
```

## 📚 Tài liệu thêm

- [SYNC_SERVICE_GUIDE.md](./SYNC_SERVICE_GUIDE.md) - Hướng dẫn chi tiết về Sync Service
- [VERIFICATION_REPORT.md](./VERIFICATION_REPORT.md) - Báo cáo kiểm tra hệ thống
- [IMPLEMENTATION_SUMMARY.md](./IMPLEMENTATION_SUMMARY.md) - Tổng quan implementation

## 💡 Tips

- **Ctrl+C** trong terminal chỉ dừng script hiện tại, không dừng services
- Luôn dùng `./stop-local.sh` để dừng đúng cách
- Logs được lưu trong thư mục `logs/` để debug sau này
- Backend sử dụng nodemon nên sẽ tự động restart khi code thay đổi
- Frontend sử dụng Vite HMR nên thay đổi sẽ reflect ngay lập tức

---

**Chúc bạn code vui vẻ! 🎉**


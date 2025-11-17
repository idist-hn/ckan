# 🎉 CKAN SETUP HOÀN THÀNH!

## ✅ Trạng thái hiện tại

CKAN đã được cài đặt và chạy thành công trên Docker!

### 🚀 Services đang chạy:
- ✅ **PostgreSQL 12** - Database (port 5432)
- ✅ **Redis 7** - Cache & Background jobs (port 6379)
- ✅ **Solr** - Search engine (port 8983)
- ✅ **CKAN** - Web application (port 5000)

### 🌐 Truy cập CKAN:
**URL:** http://localhost:5000

### 🔐 Thông tin đăng nhập Admin:
- **Username:** `admin`
- **Password:** `admin123`
- **Email:** `admin@example.com`

---

## 📝 Các bước đã thực hiện

### 1. Khởi động Docker services ✅
```powershell
cd test-infrastructure
docker compose up -d
```

### 2. Cài đặt dependencies ✅
```powershell
docker compose exec ckan bash -c "pip install --upgrade pip setuptools wheel"
docker compose exec ckan bash -c "pip install -r requirements.txt"
docker compose exec ckan bash -c "pip install -e ."
docker compose exec ckan bash -c "apt-get update && apt-get install -y postgresql-client"
```

### 3. Tạo database users và databases ✅
```powershell
docker compose exec ckan-postgres psql -U ckan -c "CREATE USER ckan_default WITH PASSWORD 'pass';"
docker compose exec ckan-postgres psql -U ckan -c "CREATE USER datastore_write WITH PASSWORD 'pass';"
docker compose exec ckan-postgres psql -U ckan -c "CREATE USER datastore_read WITH PASSWORD 'pass';"
docker compose exec ckan-postgres psql -U ckan -c "CREATE DATABASE ckan_test OWNER ckan_default;"
docker compose exec ckan-postgres psql -U ckan -c "CREATE DATABASE datastore_test OWNER datastore_write;"
```

### 4. Khởi tạo CKAN database ✅
```powershell
docker compose exec ckan bash -c "ckan -c test-core-ci.ini db init"
```
**Kết quả:** `Upgrading DB: SUCCESS`

### 5. Chạy CKAN server ✅
```powershell
docker compose exec ckan bash -c "ckan -c test-core-ci.ini run -H 0.0.0.0"
```
**Server:** http://localhost:5000

### 6. Tạo admin user ✅
```powershell
docker compose exec ckan bash -c "ckan -c test-core-ci.ini user add admin email=admin@example.com password=admin123"
docker compose exec ckan bash -c "ckan -c test-core-ci.ini sysadmin add admin"
```

---

## 🔧 Các lệnh hữu ích

### Quản lý Docker containers

```powershell
# Xem trạng thái
docker compose ps

# Xem logs CKAN
docker compose logs -f ckan

# Xem logs PostgreSQL
docker compose logs -f ckan-postgres

# Dừng containers
docker compose down

# Khởi động lại
docker compose up -d
```

### Chạy CKAN server

```powershell
# Chạy server
docker compose exec ckan bash -c "ckan -c test-core-ci.ini run -H 0.0.0.0"

# Hoặc vào container
docker compose exec ckan bash
# Trong container:
ckan -c test-core-ci.ini run -H 0.0.0.0
```

### Quản lý users

```powershell
# Tạo user mới
docker compose exec ckan bash -c "ckan -c test-core-ci.ini user add <username> email=<email> password=<password>"

# Gán quyền sysadmin
docker compose exec ckan bash -c "ckan -c test-core-ci.ini sysadmin add <username>"

# Liệt kê users
docker compose exec ckan bash -c "ckan -c test-core-ci.ini user list"
```

### Quản lý database

```powershell
# Kết nối PostgreSQL
docker compose exec ckan-postgres psql -U ckan_default -d ckan_test

# Xem danh sách bảng
docker compose exec ckan-postgres psql -U ckan_default -d ckan_test -c "\dt"

# Backup database
docker compose exec ckan-postgres pg_dump -U ckan_default ckan_test > backup.sql

# Restore database
docker compose exec -T ckan-postgres psql -U ckan_default ckan_test < backup.sql
```

### Làm việc với CKAN CLI

```powershell
# Vào container
docker compose exec ckan bash

# Trong container, các lệnh CKAN:
ckan -c test-core-ci.ini --help                    # Xem tất cả lệnh
ckan -c test-core-ci.ini user list                 # Liệt kê users
ckan -c test-core-ci.ini dataset list              # Liệt kê datasets
ckan -c test-core-ci.ini search-index rebuild      # Rebuild search index
ckan -c test-core-ci.ini db clean                  # Xóa dữ liệu test
```

---

## 🧪 Chạy Tests ✅

### Kết quả tests đã chạy:
- ✅ **test_common.py**: 21/21 tests PASSED
- ✅ **test_user.py**: 2/2 tests PASSED
- ✅ **ckan/tests/lib/**: 603 tests PASSED, 1 skipped

### Các lệnh test:

```powershell
# Cài đặt dev dependencies (đã hoàn thành)
docker compose exec ckan bash -c "pip install -r dev-requirements.txt"

# Chạy test module cụ thể
docker compose exec ckan bash -c "pytest --ckan-ini=test-core-ci.ini ckan/tests/test_common.py -v"

# Chạy tất cả tests trong thư mục lib
docker compose exec ckan bash -c "pytest --ckan-ini=test-core-ci.ini ckan/tests/lib/ -v"

# Chạy test với pattern
docker compose exec ckan bash -c "pytest --ckan-ini=test-core-ci.ini ckan/tests/model/test_user.py -v -k 'test_get'"

# Chạy test với coverage
docker compose exec ckan bash -c "pytest --ckan-ini=test-core-ci.ini --cov=ckan ckan/tests/test_common.py"

# Chạy test và dừng sau 5 lỗi đầu tiên
docker compose exec ckan bash -c "pytest --ckan-ini=test-core-ci.ini ckan/tests/ --maxfail=5"
```

---

## 📚 Tài liệu tham khảo

- **CKAN Documentation:** https://docs.ckan.org
- **API Guide:** https://docs.ckan.org/en/latest/api/
- **Extension Development:** https://docs.ckan.org/en/latest/extensions/
- **Theming Guide:** https://docs.ckan.org/en/latest/theming/
- **GitHub Repository:** https://github.com/ckan/ckan

---

## ❓ Troubleshooting

### Lỗi: "Cannot connect to database"
```powershell
# Kiểm tra PostgreSQL
docker compose ps
docker compose logs ckan-postgres

# Restart PostgreSQL
docker compose restart ckan-postgres
```

### Lỗi: "Solr connection failed"
```powershell
# Kiểm tra Solr
docker compose logs ckan-solr

# Restart Solr
docker compose restart ckan-solr
```

### Lỗi: "Redis connection failed"
```powershell
# Kiểm tra Redis
docker compose exec ckan-redis redis-cli ping

# Restart Redis
docker compose restart ckan-redis
```

### Server không khởi động
```powershell
# Xem logs chi tiết
docker compose logs -f ckan

# Kiểm tra tất cả services
docker compose ps

# Restart tất cả
docker compose down
docker compose up -d
```


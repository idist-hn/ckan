# 🚀 QUICK START - CKAN Local Setup

## ✅ Trạng thái hiện tại

Các Docker services đã được khởi động thành công:
- ✅ PostgreSQL (database) - Running
- ✅ Redis (cache) - Running  
- ✅ Solr (search engine) - Running
- ✅ CKAN Container (Python 3.10) - Running

## 📝 Các bước tiếp theo

### Bước 1: Vào container CKAN

```powershell
cd test-infrastructure
docker compose exec ckan bash
```

### Bước 2: Cài đặt dependencies (trong container)

```bash
# Cài đặt system dependencies
./test-infrastructure/install_deps.sh

# Khởi tạo database và môi trường
./test-infrastructure/init_environment.sh
```

### Bước 3: Chạy CKAN (trong container)

```bash
# Chạy development server
ckan -c test-core-ci.ini run -H 0.0.0.0
```

### Bước 4: Truy cập CKAN

Mở trình duyệt và truy cập: **http://localhost:5000**

---

## 🔧 Các lệnh hữu ích

### Quản lý Docker containers

```powershell
# Xem trạng thái containers
docker compose ps

# Xem logs
docker compose logs -f ckan

# Dừng containers
docker compose down

# Khởi động lại
docker compose up -d
```

### Làm việc với CKAN (trong container)

```bash
# Tạo admin user
ckan -c test-core-ci.ini user add admin email=admin@example.com password=admin123
ckan -c test-core-ci.ini sysadmin add admin

# Tạo dữ liệu mẫu
ckan -c test-core-ci.ini seed basic

# Rebuild search index
ckan -c test-core-ci.ini search-index rebuild

# Chạy tests
pytest --ckan-ini=test-core-ci.ini ckan/tests
```

### Kiểm tra services

```powershell
# PostgreSQL
docker compose exec ckan-postgres psql -U ckan -d ckan_test -c "\dt"

# Redis
docker compose exec ckan-redis redis-cli ping

# Solr
# Truy cập: http://localhost:8983/solr (nếu port được expose)
```

---

## 🎯 PHƯƠNG ÁN KHÁC: Setup trực tiếp trên Windows

Nếu bạn muốn chạy CKAN trực tiếp trên Windows (không dùng Docker):

### 1. Cài đặt Python 3.10

- Tải từ: https://www.python.org/downloads/release/python-31011/
- Chọn "Windows installer (64-bit)"
- **Quan trọng**: Tick "Add Python 3.10 to PATH"

### 2. Tạo Virtual Environment

```powershell
# Quay về thư mục gốc
cd ..

# Tạo virtual environment
py -3.10 -m venv venv

# Kích hoạt (nếu gặp lỗi, chạy: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser)
.\venv\Scripts\Activate.ps1
```

### 3. Cài đặt CKAN

```powershell
# Upgrade pip
python -m pip install --upgrade pip setuptools

# Cài đặt dependencies
pip install -r requirements.txt
pip install -r dev-requirements.txt

# Cài đặt CKAN
pip install -e .
```

### 4. Cấu hình và chạy

```powershell
# Tạo config file
mkdir config
ckan generate config config/ckan.ini

# Chỉnh sửa config/ckan.ini:
# - sqlalchemy.url = postgresql://ckan:ckan@localhost/ckan_test
# - solr_url = http://localhost:8983/solr/ckan
# - ckan.redis.url = redis://localhost:6379/0

# Khởi tạo database
ckan -c config/ckan.ini db init

# Chạy CKAN
ckan -c config/ckan.ini run
```

---

## 📚 Tài liệu tham khảo

- [CKAN Documentation](https://docs.ckan.org)
- [Installation Guide](https://docs.ckan.org/en/latest/maintaining/installing/index.html)
- [API Guide](https://docs.ckan.org/en/latest/api/index.html)
- [Extension Development](https://docs.ckan.org/en/latest/extensions/index.html)

---

## ❓ Troubleshooting

### Lỗi: "Cannot connect to database"
```bash
# Kiểm tra PostgreSQL
docker compose ps
docker compose logs ckan-postgres
```

### Lỗi: "Solr connection failed"
```bash
# Kiểm tra Solr
docker compose logs ckan-solr
```

### Lỗi: "Redis connection failed"
```bash
# Kiểm tra Redis
docker compose exec ckan-redis redis-cli ping
```



# 🔑 Thông Tin Đăng Nhập CKAN

## 🌐 Truy Cập Website

CKAN đang chạy tại:
```
http://localhost:5000
```

## 👤 Tạo Tài Khoản

### Cách 1: Đăng Ký Qua Web (Đơn Giản Nhất)

1. **Mở trình duyệt** và truy cập: http://localhost:5000

2. **Click "Register"** (góc trên bên phải)

3. **Điền form đăng ký:**
   - Username: `admin` (hoặc tên bạn muốn)
   - Full name: `Administrator`
   - Email: `admin@localhost`
   - Password: `admin123` (hoặc password bạn muốn)
   - Confirm password: `admin123`

4. **Click "Create Account"**

5. **Nâng cấp lên Sysadmin** (chạy trong Docker):
   ```bash
   docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini sysadmin add admin"
   ```

### Cách 2: Tạo Trực Tiếp Trong Docker

Vì CKAN đang chạy trong Docker với cấu hình test, bạn cần:

1. **Tạo file config đúng** (đã có sẵn trong container)

2. **Chạy lệnh tạo user:**
   ```bash
   # Vào container
   docker exec -it test-infrastructure-ckan-1 bash
   
   # Trong container, chạy:
   cd /usr/src
   
   # Tạo database nếu chưa có
   ckan -c test-core-ci.ini db init
   
   # Tạo admin user
   ckan -c test-core-ci.ini sysadmin add admin email=admin@localhost password=admin123
   ```

### Cách 3: Sử Dụng Script PowerShell

Tôi sẽ tạo script tự động cho bạn...

## 🔧 Cấu Hình Docker

CKAN đang chạy trong Docker với:
- **Container**: `test-infrastructure-ckan-1`
- **Database**: `test-infrastructure-ckan-postgres-1`
- **Solr**: `test-infrastructure-ckan-solr-1`
- **Redis**: `test-infrastructure-ckan-redis-1`
- **Port**: 5000

## 📝 Thông Tin Database

- **Host**: ckan-postgres (trong Docker network)
- **Database**: ckan_test
- **User**: ckan_default
- **Password**: pass

## ⚠️ Lưu Ý Quan Trọng

1. **Đây là môi trường TEST**, không phải production
2. **Config file**: `test-core-ci.ini` (trong container)
3. **Database** ở container riêng, không phải localhost
4. **Theme đã được tạo** nhưng chưa kích hoạt trong test config

## 🎨 Kích Hoạt Theme

Để kích hoạt theme `datagovsg_theme`, bạn cần:

1. **Sửa file config** trong container:
   ```bash
   docker exec -it test-infrastructure-ckan-1 bash
   cd /usr/src
   nano test-core-ci.ini
   ```

2. **Thêm plugin:**
   ```ini
   ckan.plugins = datagovsg_theme
   ```

3. **Restart container:**
   ```bash
   docker restart test-infrastructure-ckan-1
   ```

## 🚀 Khởi Động Web Server

Nếu server chưa chạy:

```bash
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0"
```

## 🔍 Kiểm Tra

1. **Kiểm tra container đang chạy:**
   ```bash
   docker ps | findstr ckan
   ```

2. **Xem logs:**
   ```bash
   docker logs test-infrastructure-ckan-1
   ```

3. **Truy cập web:**
   ```
   http://localhost:5000
   ```

## 💡 Khuyến Nghị

**Cách đơn giản nhất:**

1. Mở http://localhost:5000
2. Click "Register" và tạo tài khoản
3. Sau đó nâng cấp lên sysadmin bằng lệnh Docker

Hoặc nếu bạn muốn, tôi có thể tạo script tự động để làm tất cả!

---

**Bạn muốn tôi làm gì tiếp theo?**

A. Tạo script tự động tạo admin user
B. Hướng dẫn kích hoạt theme trong Docker
C. Khởi động web server ngay
D. Tất cả các bước trên

Cho tôi biết nhé! 🚀


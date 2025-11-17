# 🔑 THÔNG TIN ĐĂNG NHẬP CKAN

## ✅ TÀI KHOẢN ĐÃ TẠO THÀNH CÔNG!

Tài khoản admin đã được tạo và sẵn sàng sử dụng!

## 🌐 Trang Đăng Nhập

```
http://localhost:5000/user/login
```

## 👤 Thông Tin Đăng Nhập

### Tài Khoản Admin (Sysadmin)

```
Username: admin
Password: admin123
Email: admin@localhost
```

## 📝 Hướng Dẫn Đăng Nhập

### Bước 1: Truy Cập Trang Login

Mở trình duyệt và vào:
```
http://localhost:5000/user/login
```

### Bước 2: Nhập Thông Tin

- **Username**: `admin`
- **Password**: `admin123`

### Bước 3: Click "Login"

Sau khi đăng nhập thành công, bạn sẽ thấy:
- Tên "Administrator" ở góc trên bên phải
- Menu "Dashboard", "Settings", "Log out"
- Quyền admin để quản lý toàn bộ hệ thống

## 🎯 Sau Khi Đăng Nhập

Bạn có thể:

### 1. Tạo Datasets
- Click "Datasets" > "Add Dataset"
- Điền thông tin và upload data
- Publish dataset

### 2. Quản Lý Organizations
- Click "Organizations" > "Add Organization"
- Tạo và quản lý organizations
- Thêm members

### 3. Quản Lý Users
- Truy cập: http://localhost:5000/ckan-admin/users
- Xem danh sách users
- Thêm/xóa/chỉnh sửa users

### 4. Cấu Hình Hệ Thống
- Truy cập: http://localhost:5000/ckan-admin/config
- Thay đổi site title, logo, description
- Cấu hình các tính năng

## 🔐 Các Tài Khoản Khác

Hệ thống cũng có các tài khoản test khác (từ database test):

```
test.ckan.net (sysadmin)
fcarter
stephanie95
darrellharvey
oparker
ashley45
... (và nhiều user khác)
```

**Lưu ý**: Các tài khoản này là test users, không có password được set.

## 🛡️ Bảo Mật

### Đổi Password (Khuyến Nghị)

Sau khi đăng nhập lần đầu, nên đổi password:

1. Click vào tên "Administrator" (góc trên phải)
2. Click "Settings"
3. Nhập password mới
4. Click "Update Profile"

### Tạo User Mới

```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user add USERNAME email=EMAIL password=PASSWORD fullname='FULL NAME'"
```

### Nâng Cấp User Lên Sysadmin

```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini sysadmin add USERNAME"
```

## 🐛 Xử Lý Sự Cố Login

### Không Login Được?

**Kiểm tra 1: Username và Password đúng chưa?**
- Username: `admin` (không phải email)
- Password: `admin123`
- Phân biệt chữ hoa/thường

**Kiểm tra 2: Server có đang chạy?**
```powershell
docker exec test-infrastructure-ckan-1 ps aux | findstr ckan
```

**Kiểm tra 3: User có tồn tại?**
```powershell
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user show admin"
```

### Quên Password?

Reset password:
```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user setpass admin"
```

Sau đó nhập password mới khi được hỏi.

### Tạo Lại User Admin

Nếu cần tạo lại:
```bash
# Xóa user cũ
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user remove admin"

# Tạo user mới
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user add admin email=admin@localhost password=admin123 fullname='Administrator'"

# Nâng cấp lên sysadmin
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini sysadmin add admin"
```

## 📊 Kiểm Tra Thông Tin User

### Xem Thông Tin Admin
```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user show admin"
```

### Liệt Kê Tất Cả Sysadmins
```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini sysadmin list"
```

### Liệt Kê Tất Cả Users
```bash
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini user list"
```

## 🎨 Sau Khi Login

### Trang Admin
```
http://localhost:5000/ckan-admin
```

Tại đây bạn có thể:
- Quản lý config
- Quản lý users
- Xem trash (datasets đã xóa)
- Reset database

### Dashboard
```
http://localhost:5000/dashboard
```

Xem:
- Datasets của bạn
- Organizations của bạn
- News feed
- Activity stream

## 💡 Tips

1. **Bookmark trang login** để truy cập nhanh
2. **Đổi password ngay** sau lần đăng nhập đầu
3. **Tạo thêm users** cho team members
4. **Phân quyền đúng** cho từng user
5. **Backup database** thường xuyên

## 🎉 Thành Công!

Bây giờ bạn có thể:
- ✅ Login vào CKAN
- ✅ Quản lý toàn bộ hệ thống
- ✅ Tạo datasets, organizations
- ✅ Cấu hình site
- ✅ Quản lý users

**Hãy login và khám phá CKAN với theme Data.gov.sg!** 🚀

---

## 📞 Cần Trợ Giúp?

Nếu vẫn không login được:
1. Kiểm tra logs: `docker logs -f test-infrastructure-ckan-1`
2. Restart server
3. Xem file READY_TO_USE.md
4. Check database connection

**Chúc bạn thành công!** 🎊


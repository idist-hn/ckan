# 🚀 Cách Khởi Động CKAN Web Server

## ⚡ Cách Nhanh Nhất

### Cách 1: Sử dụng Script PowerShell (Windows)

```powershell
# Chạy script tự động
.\start-ckan.ps1
```

### Cách 2: Thủ Công

```bash
# Bước 1: Kích hoạt virtual environment (nếu có)
# Windows:
E:\cdsqg\venv\Scripts\Activate.ps1

# Linux/Mac:
source /usr/lib/ckan/default/bin/activate

# Bước 2: Khởi động server
ckan -c development.ini run

# Hoặc nếu lệnh trên không hoạt động:
python -m ckan.cli -c development.ini run
```

### Cách 3: Nếu Chưa Cài Đặt CKAN

Xem file `START_SERVER.md` để biết hướng dẫn chi tiết về:
- Cài đặt virtual environment
- Cài đặt CKAN
- Cấu hình database
- Khởi động services (PostgreSQL, Solr, Redis)

## 🌐 Truy Cập Website

Sau khi server khởi động thành công, mở trình duyệt:

```
http://localhost:5000
```

## ✅ Kiểm Tra Theme

Bạn sẽ thấy:
- ✅ Header màu tím (#6253e8)
- ✅ Homepage với hero section
- ✅ Search bar lớn
- ✅ Cards bo tròn với shadow
- ✅ Footer mới với 4 columns

## 🐛 Nếu Gặp Lỗi

### "ckan: command not found"
```bash
# Sử dụng:
python -m ckan.cli -c development.ini run
```

### "Database connection error"
```bash
# Khởi động PostgreSQL
# Windows:
Start-Service postgresql*

# Linux:
sudo systemctl start postgresql

# Tạo database:
createdb -O ckan_default ckan_dev
ckan -c development.ini db init
```

### "Solr connection error"
```bash
# Kiểm tra Solr:
http://localhost:8983/solr

# Khởi động Solr nếu cần
```

### Theme không hiển thị
```bash
# Xóa cache
ckan -c development.ini cache clear

# Hard refresh browser
Ctrl + Shift + R
```

## 📚 Tài Liệu Chi Tiết

- **START_SERVER.md** - Hướng dẫn đầy đủ về khởi động server
- **development.ini** - File cấu hình (đã có theme kích hoạt)
- **ckanext/datagovsg_theme/QUICKSTART.md** - Hướng dẫn theme

## 🎯 Files Quan Trọng

1. **development.ini** - Cấu hình CKAN (theme đã kích hoạt)
2. **start-ckan.ps1** - Script tự động khởi động (Windows)
3. **START_SERVER.md** - Hướng dẫn chi tiết
4. **ckanext/datagovsg_theme/** - Theme files

## 💡 Tips

- Đảm bảo PostgreSQL, Solr, Redis đang chạy
- Kích hoạt virtual environment trước khi chạy
- Xem logs để debug nếu có lỗi
- Hard refresh browser (Ctrl+Shift+R) để thấy thay đổi CSS

---

**Chúc bạn thành công!** 🎉

Nếu cần trợ giúp, xem file **START_SERVER.md** để biết hướng dẫn chi tiết.


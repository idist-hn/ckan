# 🚀 Hướng Dẫn Khởi Động CKAN Web Server

## 📋 Yêu Cầu

Trước khi khởi động, đảm bảo bạn đã:
- ✅ Cài đặt Python (3.7+)
- ✅ Cài đặt PostgreSQL
- ✅ Cài đặt Solr
- ✅ Cài đặt Redis
- ✅ Tạo virtual environment cho CKAN

## 🔧 Các Bước Khởi Động

### Bước 1: Kích Hoạt Virtual Environment

Nếu bạn đã có virtual environment cho CKAN:

**Windows:**
```powershell
# Tìm virtual environment (thường ở một trong các vị trí sau)
# E:/cdsqg/venv/Scripts/Activate.ps1
# hoặc
# C:/ckan/venv/Scripts/Activate.ps1

# Kích hoạt
E:/cdsqg/venv/Scripts/Activate.ps1
```

**Linux/Mac:**
```bash
source /usr/lib/ckan/default/bin/activate
```

### Bước 2: Kiểm Tra CKAN Đã Cài Đặt

```bash
ckan --version
# Hoặc
python -m ckan --version
```

### Bước 3: Khởi Động Server

**Cách 1: Sử dụng CKAN CLI (Khuyến nghị)**
```bash
ckan -c development.ini run
```

**Cách 2: Sử dụng Python**
```bash
python -m ckan.cli -c development.ini run
```

**Cách 3: Sử dụng paster (CKAN cũ)**
```bash
paster serve development.ini
```

### Bước 4: Truy Cập Website

Mở trình duyệt và truy cập:
```
http://localhost:5000
```

## 🎨 Kiểm Tra Theme

Sau khi server khởi động, bạn sẽ thấy:

✅ **Header màu tím** (#6253e8) - Gradient đẹp mắt  
✅ **Homepage hiện đại** - Hero section với search bar lớn  
✅ **Cards bo tròn** - Với shadow effects  
✅ **Hover animations** - Mượt mà  
✅ **Footer mới** - 4 columns với social links  

## 🐛 Xử Lý Sự Cố

### Lỗi: "ckan: command not found"

**Giải pháp:**
1. Kích hoạt virtual environment
2. Hoặc sử dụng: `python -m ckan.cli -c development.ini run`

### Lỗi: Database connection

**Giải pháp:**
1. Kiểm tra PostgreSQL đang chạy:
   ```bash
   # Windows
   Get-Service postgresql*
   
   # Linux
   sudo systemctl status postgresql
   ```

2. Tạo database nếu chưa có:
   ```bash
   createdb -O ckan_default ckan_dev
   createdb -O ckan_default datastore_dev
   ```

3. Khởi tạo database:
   ```bash
   ckan -c development.ini db init
   ```

### Lỗi: Solr connection

**Giải pháp:**
1. Kiểm tra Solr đang chạy:
   ```
   http://localhost:8983/solr
   ```

2. Khởi động Solr nếu chưa chạy:
   ```bash
   # Linux
   sudo systemctl start solr
   
   # Windows - chạy từ thư mục Solr
   bin\solr.cmd start
   ```

### Lỗi: Redis connection

**Giải pháp:**
1. Kiểm tra Redis:
   ```bash
   # Windows
   Get-Service redis*
   
   # Linux
   sudo systemctl status redis
   ```

2. Khởi động Redis:
   ```bash
   # Linux
   sudo systemctl start redis
   
   # Windows
   redis-server
   ```

### Theme không hiển thị

**Giải pháp:**
1. Kiểm tra `development.ini` có `datagovsg_theme` trong `ckan.plugins`
2. Xóa cache:
   ```bash
   ckan -c development.ini cache clear
   ```
3. Hard refresh browser: `Ctrl + Shift + R`

## 📝 File Cấu Hình

Tôi đã tạo file `development.ini` với cấu hình sau:

```ini
# Theme đã được kích hoạt
ckan.plugins = stats text_view image_view recline_view datagovsg_theme

# Site settings
ckan.site_title = Cổng Dữ Liệu Mở
ckan.site_description = Khám phá dữ liệu quốc gia và truy cập API
ckan.site_url = http://localhost:5000

# Locale
ckan.locale_default = vi
ckan.locale_order = vi en
```

## 🔑 Tạo Admin User (Nếu Chưa Có)

```bash
ckan -c development.ini sysadmin add admin email=admin@example.com
```

Sau đó đăng nhập với:
- Username: `admin`
- Password: (bạn sẽ được yêu cầu tạo khi chạy lệnh trên)

## 🌐 Truy Cập Các Trang

Sau khi server chạy:

- **Homepage**: http://localhost:5000
- **Datasets**: http://localhost:5000/dataset
- **Organizations**: http://localhost:5000/organization
- **Groups**: http://localhost:5000/group
- **Admin**: http://localhost:5000/ckan-admin (cần đăng nhập admin)

## 📊 Kiểm Tra Theme

### 1. Homepage
- [ ] Hero section với gradient purple
- [ ] Search bar lớn
- [ ] Featured cards
- [ ] Footer mới

### 2. Header
- [ ] Màu tím gradient
- [ ] Navigation menu
- [ ] User account menu (nếu đã đăng nhập)

### 3. Dataset Pages
- [ ] Cards bo tròn
- [ ] Hover effects
- [ ] Tags styled
- [ ] Search bar styled

### 4. Responsive
- [ ] Test trên mobile (F12 > Toggle device toolbar)
- [ ] Test trên tablet
- [ ] Test trên desktop

## 🎯 Nếu Không Có Virtual Environment

### Tạo Virtual Environment Mới

**Windows:**
```powershell
# Tạo venv
python -m venv E:/cdsqg/venv

# Kích hoạt
E:/cdsqg/venv/Scripts/Activate.ps1

# Cài đặt CKAN
cd E:/cdsqg/ckan/sources/ckan
pip install -e .
pip install -r requirements.txt
```

**Linux:**
```bash
# Tạo venv
python3 -m venv /usr/lib/ckan/default

# Kích hoạt
source /usr/lib/ckan/default/bin/activate

# Cài đặt CKAN
cd /usr/lib/ckan/default/src/ckan
pip install -e .
pip install -r requirements.txt
```

## 🚀 Quick Start (Nếu Đã Setup)

```bash
# 1. Kích hoạt venv
E:/cdsqg/venv/Scripts/Activate.ps1

# 2. Chuyển đến thư mục CKAN
cd E:/cdsqg/ckan/sources/ckan

# 3. Khởi động server
ckan -c development.ini run

# 4. Mở browser
# http://localhost:5000
```

## 📞 Cần Trợ Giúp?

Nếu gặp vấn đề:

1. **Kiểm tra logs** - Server sẽ hiển thị lỗi trong console
2. **Kiểm tra services** - PostgreSQL, Solr, Redis phải đang chạy
3. **Kiểm tra config** - File `development.ini` phải đúng
4. **Xem tài liệu CKAN** - https://docs.ckan.org

## 🎉 Thành Công!

Khi server chạy thành công, bạn sẽ thấy:

```
Starting server in PID 12345.
Serving on http://0.0.0.0:5000
```

Mở browser và thưởng thức theme mới! 🚀

---

**Lưu ý**: 
- File `development.ini` đã được tạo với theme `datagovsg_theme` đã kích hoạt
- Đảm bảo PostgreSQL, Solr, Redis đang chạy trước khi khởi động CKAN
- Nếu chưa có database, chạy `ckan -c development.ini db init`

**Chúc bạn thành công!** 🎊


# ✅ CKAN ĐÃ SẴN SÀNG SỬ DỤNG!

## 🎉 Hoàn Tất Setup!

CKAN web server đã được khởi động thành công với theme Data.gov.sg!

## 🌐 Truy Cập Website

Mở trình duyệt và truy cập:

```
http://localhost:5000
```

## 🔑 Đăng Nhập

### Cách 1: Đăng Ký Tài Khoản Mới (Khuyến Nghị)

1. Truy cập: http://localhost:5000
2. Click **"Register"** (góc trên bên phải)
3. Điền thông tin:
   - **Username**: `admin` (hoặc tên bạn muốn)
   - **Full Name**: `Administrator`
   - **Email**: `admin@localhost`
   - **Password**: `admin123`
   - **Confirm Password**: `admin123`
4. Click **"Create Account"**
5. Sau khi đăng ký, nâng cấp lên sysadmin:
   ```powershell
   docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini sysadmin add admin"
   ```

### Cách 2: Nếu Đã Có Tài Khoản

Nếu bạn đã tạo tài khoản trước đó, login với:
- **Username**: `admin`
- **Password**: `admin123`

## 🎨 Theme Data.gov.sg

Theme đã được kích hoạt! Bạn sẽ thấy:

✅ **Header màu tím** (#6253e8) với gradient đẹp mắt  
✅ **Homepage hiện đại** với hero section  
✅ **Search bar lớn** dễ sử dụng  
✅ **Cards bo tròn** với shadow effects  
✅ **Hover animations** mượt mà  
✅ **Footer mới** với 4 columns  

## 📊 Các Trang Chính

- **Homepage**: http://localhost:5000
- **Datasets**: http://localhost:5000/dataset
- **Organizations**: http://localhost:5000/organization
- **Groups**: http://localhost:5000/group
- **About**: http://localhost:5000/about

## 🔧 Quản Lý Server

### Xem Logs
```powershell
docker logs -f test-infrastructure-ckan-1
```

### Dừng Server
```powershell
docker exec test-infrastructure-ckan-1 pkill -f "ckan.*run"
```

### Khởi Động Lại Server
```powershell
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0 --port 5000"
```

### Restart Container
```powershell
docker restart test-infrastructure-ckan-1
```

## 🎯 Tính Năng Theme

### 1. Homepage
- Hero section với gradient purple
- Search bar lớn, nổi bật
- Featured datasets section
- 3 feature cards (5000+ Datasets, Real-time APIs, Free & Open)

### 2. Header
- Gradient background (#6253e8 to #4f42ba)
- Modern navigation menu
- User account dropdown
- Responsive mobile menu

### 3. Dataset Pages
- Card-based layout
- Rounded corners (12px)
- Soft shadows
- Hover effects với lift animation

### 4. Search
- Enhanced search interface
- Purple gradient header
- Large search input
- Modern filters

### 5. Footer
- 4 columns: About, Resources, Help, Connect
- Social media links
- Copyright information
- Dark background với white text

## 🎨 Tùy Chỉnh Theme

### Thay Đổi Màu Sắc

Chỉnh sửa file `ckanext/datagovsg_theme/assets/datagovsg_theme.css`:

```css
:root {
  --primary-color: #6253e8;  /* Thay đổi màu này */
  --primary-dark: #4f42ba;
  --primary-light: #7d6ff0;
}
```

### Thêm Logo

1. Đặt logo vào `ckanext/datagovsg_theme/public/`
2. Cập nhật config trong container:
   ```bash
   docker exec -it test-infrastructure-ckan-1 bash
   cd /usr/src
   nano test-core-ci.ini
   ```
3. Thêm dòng:
   ```ini
   ckan.site_logo = /datagovsg_theme/logo.png
   ```

### Tùy Chỉnh Trang Chủ

Chỉnh sửa `ckanext/datagovsg_theme/templates/home/index.html`

## 📱 Test Responsive

1. Mở DevTools (F12)
2. Click Toggle Device Toolbar (Ctrl+Shift+M)
3. Test trên các kích thước:
   - Mobile: 375px
   - Tablet: 768px
   - Desktop: 1920px

## 🐛 Xử Lý Sự Cố

### Server không chạy?
```powershell
# Kiểm tra process
docker exec test-infrastructure-ckan-1 ps aux | findstr ckan

# Khởi động lại
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0 --port 5000"
```

### Theme không hiển thị?
```powershell
# Kiểm tra config
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && grep 'datagovsg_theme' test-core-ci.ini"

# Restart server
docker exec test-infrastructure-ckan-1 pkill -f "ckan.*run"
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0 --port 5000"
```

### CSS không load?
1. Hard refresh browser: `Ctrl + Shift + R`
2. Clear browser cache
3. Restart CKAN server

### Port 5000 đã được sử dụng?
```powershell
# Tìm process đang dùng port 5000
netstat -ano | findstr :5000

# Kill process (thay PID bằng số thực tế)
taskkill /PID <PID> /F
```

## 📚 Tài Liệu

- **QUICKSTART.md** - Hướng dẫn nhanh về theme
- **README.md** - Tài liệu đầy đủ
- **CONFIGURATION.md** - Cấu hình nâng cao
- **FEATURES.md** - Chi tiết tính năng
- **LOGIN_INFO.md** - Thông tin đăng nhập

## 🎓 Bước Tiếp Theo

### 1. Tạo Datasets
1. Login vào CKAN
2. Click "Datasets" > "Add Dataset"
3. Điền thông tin và publish

### 2. Tạo Organizations
1. Click "Organizations" > "Add Organization"
2. Điền thông tin organization
3. Thêm members

### 3. Tùy Chỉnh Theme
1. Thay đổi màu sắc
2. Thêm logo
3. Tùy chỉnh nội dung trang chủ

### 4. Thêm Dữ Liệu
1. Upload CSV, Excel files
2. Kết nối với APIs
3. Import từ nguồn khác

## 💡 Tips

- **Sử dụng Incognito** để test theme mà không bị cache
- **Backup database** thường xuyên
- **Test trên nhiều trình duyệt** (Chrome, Firefox, Safari, Edge)
- **Kiểm tra responsive** trên mobile devices
- **Đọc CKAN docs** để hiểu thêm về tính năng

## 🎊 Chúc Mừng!

Bạn đã setup thành công CKAN với theme Data.gov.sg!

**Những gì bạn có:**
- ✅ CKAN server đang chạy
- ✅ Theme Data.gov.sg đã kích hoạt
- ✅ Database đã được khởi tạo
- ✅ Tài liệu đầy đủ
- ✅ Scripts tự động hóa

**Hãy bắt đầu khám phá!** 🚀

---

## 📞 Cần Trợ Giúp?

1. Xem logs: `docker logs -f test-infrastructure-ckan-1`
2. Đọc tài liệu trong thư mục `ckanext/datagovsg_theme/`
3. Check CKAN docs: https://docs.ckan.org

**Chúc bạn thành công!** 🎉


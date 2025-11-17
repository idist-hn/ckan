# 🚀 Quick Start - Data.gov.sg Theme

Chào mừng bạn đến với Data.gov.sg Theme cho CKAN! Theme này được thiết kế dựa trên giao diện của [data.gov.sg](https://data.gov.sg).

## ✨ Tính Năng Chính

- 🎨 **Màu sắc hiện đại**: Màu tím chủ đạo (#6253e8) giống data.gov.sg
- 📱 **Responsive**: Tương thích với mọi thiết bị
- ⚡ **Hiệu suất cao**: CSS được tối ưu hóa
- 🎯 **Dễ sử dụng**: Giao diện thân thiện, dễ điều hướng
- 🔧 **Dễ tùy chỉnh**: Thay đổi màu sắc và nội dung dễ dàng

## 📦 Cài Đặt Nhanh (3 Bước)

### Bước 1: Kích hoạt plugin

Mở file cấu hình CKAN của bạn (thường là `ckan.ini` hoặc `development.ini`):

```bash
# Tìm file config
# Thường ở: /etc/ckan/default/ckan.ini
# Hoặc: development.ini trong thư mục CKAN

# Mở file để chỉnh sửa
nano /etc/ckan/default/ckan.ini
```

Thêm `datagovsg_theme` vào danh sách plugins:

```ini
# Tìm dòng ckan.plugins và thêm datagovsg_theme vào cuối
ckan.plugins = stats text_view image_view recline_view datagovsg_theme

# Tùy chọn: Tùy chỉnh thông tin site
ckan.site_title = Cổng Dữ Liệu Mở
ckan.site_description = Khám phá dữ liệu quốc gia và truy cập API
```

### Bước 2: Khởi động lại CKAN

**Nếu đang chạy development server:**
```bash
# Dừng server hiện tại (Ctrl+C)
# Sau đó chạy lại:
ckan -c /path/to/ckan.ini run
```

**Nếu đang chạy production với systemd:**
```bash
sudo systemctl restart ckan
```

**Nếu đang chạy production với supervisor:**
```bash
sudo supervisorctl restart ckan-web
```

### Bước 3: Xóa cache (nếu cần)

```bash
ckan -c /path/to/ckan.ini cache clear
```

## ✅ Kiểm Tra Cài Đặt

Mở trình duyệt và truy cập CKAN của bạn. Bạn sẽ thấy:

- ✅ Header màu tím (#6253e8)
- ✅ Giao diện hiện đại với card bo tròn
- ✅ Thanh search được cải thiện
- ✅ Hiệu ứng hover mượt mà
- ✅ Footer được thiết kế lại

## 🎨 Tùy Chỉnh Nhanh

### Thay Đổi Màu Chủ Đạo

Mở file `ckanext/datagovsg_theme/assets/datagovsg_theme.css` và tìm:

```css
:root {
  --primary-color: #6253e8;  /* Thay đổi màu này */
}
```

Ví dụ màu khác:
- Xanh dương: `#3b82f6`
- Xanh lá: `#10b981`
- Đỏ: `#ef4444`
- Cam: `#f59e0b`

### Thêm Logo Của Bạn

1. Đặt file logo vào `ckanext/datagovsg_theme/public/`
2. Cập nhật config:
```ini
ckan.site_logo = /datagovsg_theme/logo.png
```

### Tùy Chỉnh Trang Chủ

Chỉnh sửa `ckanext/datagovsg_theme/templates/home/index.html`:

```jinja2
<h1>{{ _("Tiêu đề của bạn") }}</h1>
<p>{{ _("Mô tả của bạn") }}</p>
```

## 📁 Cấu Trúc Files

```
ckanext/datagovsg_theme/
├── README.md              # Tài liệu đầy đủ
├── INSTALL.md             # Hướng dẫn cài đặt
├── CONFIGURATION.md       # Hướng dẫn cấu hình
├── QUICKSTART.md          # File này
├── plugin.py              # Plugin chính
├── setup.py               # Setup file
├── assets/
│   ├── datagovsg_theme.css    # CSS chính
│   └── webassets.yml          # Cấu hình webassets
├── templates/
│   ├── base.html              # Template cơ bản
│   ├── header.html            # Header tùy chỉnh
│   ├── footer.html            # Footer tùy chỉnh
│   ├── home/
│   │   └── index.html         # Trang chủ
│   └── package/
│       └── search.html        # Trang tìm kiếm
└── public/                    # Static files (logo, images)
```

## 🎯 Các Tính Năng Đã Tùy Chỉnh

### 1. Header & Navigation
- Gradient màu tím
- Menu điều hướng hiện đại
- Hover effects mượt mà

### 2. Trang Chủ
- Hero section với gradient
- Search bar lớn, dễ sử dụng
- Featured datasets
- 3 cards giới thiệu tính năng

### 3. Trang Tìm Kiếm
- Search bar được cải thiện
- Layout card hiện đại
- Hover effects

### 4. Cards & Modules
- Bo tròn góc (12px)
- Shadow effects
- Hover animations
- Gradient headers

### 5. Buttons
- Màu tím chủ đạo
- Hover effects với transform
- Shadow khi hover

### 6. Footer
- Background tối
- 4 cột thông tin
- Social links
- Copyright info

## 🐛 Xử Lý Sự Cố

### Theme không hiển thị?

1. **Kiểm tra plugin đã được thêm chưa:**
   ```bash
   grep "ckan.plugins" /etc/ckan/default/ckan.ini
   ```
   Phải có `datagovsg_theme` trong danh sách

2. **Khởi động lại CKAN:**
   ```bash
   sudo systemctl restart ckan
   ```

3. **Xóa cache trình duyệt:**
   - Chrome/Firefox: Ctrl+Shift+R (Windows) hoặc Cmd+Shift+R (Mac)

4. **Xóa cache CKAN:**
   ```bash
   ckan -c /path/to/ckan.ini cache clear
   ```

### CSS không load?

1. **Hard refresh trình duyệt:** Ctrl+F5
2. **Kiểm tra file tồn tại:**
   ```bash
   ls -la ckanext/datagovsg_theme/assets/
   ```
3. **Xóa webassets cache:**
   ```bash
   rm -rf /var/lib/ckan/default/webassets/*
   ```

### Lỗi trong logs?

Xem CKAN logs:
```bash
tail -f /var/log/ckan/ckan.log
```

Hoặc nếu dùng development:
```bash
ckan -c development.ini run
# Logs sẽ hiển thị trực tiếp
```

## 📚 Tài Liệu Đầy Đủ

- **[README.md](README.md)** - Tài liệu đầy đủ về theme
- **[INSTALL.md](INSTALL.md)** - Hướng dẫn cài đặt chi tiết
- **[CONFIGURATION.md](CONFIGURATION.md)** - Hướng dẫn cấu hình nâng cao

## 🔗 Links Hữu Ích

- **CKAN Documentation**: https://docs.ckan.org
- **CKAN Theming Guide**: https://docs.ckan.org/en/latest/theming/
- **Data.gov.sg**: https://data.gov.sg (tham khảo design)
- **Bootstrap 5 Docs**: https://getbootstrap.com/docs/5.0/

## 💡 Tips & Tricks

### 1. Tùy chỉnh màu nhanh
Chỉ cần thay đổi `--primary-color` trong CSS, tất cả các elements sẽ tự động cập nhật.

### 2. Thêm custom CSS
Tạo file `assets/custom.css` và thêm vào `webassets.yml`

### 3. Override templates
Tạo file cùng tên trong `templates/` để override bất kỳ template nào của CKAN

### 4. Sử dụng {% ckan_extends %}
Luôn dùng `{% ckan_extends %}` ở đầu template để kế thừa template gốc

### 5. Test trên nhiều trình duyệt
Kiểm tra theme trên Chrome, Firefox, Safari, và Edge

## 🎉 Hoàn Thành!

Bạn đã cài đặt thành công Data.gov.sg Theme! 

**Tiếp theo:**
1. Tùy chỉnh màu sắc theo brand của bạn
2. Thêm logo và favicon
3. Tùy chỉnh nội dung trang chủ
4. Thêm thông tin footer
5. Test trên mobile devices

**Cần trợ giúp?** Xem [README.md](README.md) hoặc [CONFIGURATION.md](CONFIGURATION.md)

---

**Version**: 1.0.0  
**Tương thích**: CKAN 2.9+  
**License**: AGPL v3


# 🔧 SỬA LỖI "This site can't be reached"

## ✅ Xác Nhận

Tôi đã kiểm tra và xác nhận:
- ✅ CKAN server đang chạy bình thường
- ✅ Port 5000 đang listen và hoạt động
- ✅ Kết nối TCP từ Windows đến localhost:5000 **THÀNH CÔNG**
- ✅ Curl từ trong container trả về HTTP 200

**Vấn đề**: Browser không thể truy cập, có thể do cache, firewall, hoặc proxy.

---

## 🚀 GIẢI PHÁP NHANH

### Cách 1: Thử Các URL Khác Nhau

Thử lần lượt các URL sau trong browser:

```
http://127.0.0.1:5000
http://localhost:5000
http://0.0.0.0:5000
```

### Cách 2: Hard Refresh Browser

1. Mở browser
2. Nhấn **Ctrl + Shift + Delete**
3. Chọn "Cached images and files"
4. Click "Clear data"
5. Thử lại: http://localhost:5000

Hoặc đơn giản hơn:
- Nhấn **Ctrl + Shift + R** (hard refresh)
- Hoặc **Ctrl + F5**

### Cách 3: Thử Browser Khác

- **Chrome**: http://localhost:5000
- **Firefox**: http://localhost:5000
- **Edge**: http://localhost:5000
- **Brave**: http://localhost:5000

### Cách 4: Incognito/Private Mode

1. Mở **Incognito/Private window**:
   - Chrome: `Ctrl + Shift + N`
   - Firefox: `Ctrl + Shift + P`
   - Edge: `Ctrl + Shift + N`

2. Truy cập: http://localhost:5000

### Cách 5: Kiểm Tra Proxy Settings

**Chrome/Edge:**
1. Settings > System > "Open your computer's proxy settings"
2. Tắt "Use a proxy server"
3. Hoặc thêm `localhost` vào "Bypass proxy server for these addresses"

**Firefox:**
1. Settings > Network Settings
2. Chọn "No proxy"
3. Click OK

---

## 🔥 GIẢI PHÁP NÂNG CAO

### Giải Pháp A: Tắt Firewall Tạm Thời

```powershell
# Tắt Windows Firewall (tạm thời để test)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Thử truy cập: http://localhost:5000

# Bật lại Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
```

### Giải Pháp B: Thêm Firewall Rule

```powershell
# Thêm rule cho phép port 5000
New-NetFirewallRule -DisplayName "CKAN Port 5000" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow
```

### Giải Pháp C: Kiểm Tra Antivirus

Tạm thời tắt antivirus (Kaspersky, Avast, Norton, McAfee, ...) và thử lại.

### Giải Pháp D: Flush DNS

```powershell
# Clear DNS cache
ipconfig /flushdns

# Thử lại
```

### Giải Pháp E: Reset Winsock

```powershell
# Reset network stack
netsh winsock reset
netsh int ip reset

# Restart máy
Restart-Computer
```

---

## 🧪 TEST BẰNG CURL

Nếu browser vẫn không được, test bằng curl:

```powershell
# Test với curl (nếu có)
curl http://localhost:5000

# Hoặc với PowerShell
Invoke-WebRequest -Uri http://localhost:5000
```

Nếu curl hoạt động nhưng browser không, chắc chắn là vấn đề browser/proxy.

---

## 🎯 GIẢI PHÁP CUỐI CÙNG: Đổi Port

Nếu tất cả đều thất bại, thử đổi sang port khác:

### Bước 1: Dừng CKAN

```powershell
docker exec test-infrastructure-ckan-1 pkill -f "ckan.*run"
```

### Bước 2: Khởi động với port 8080

```powershell
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0 --port 8080"
```

### Bước 3: Truy cập

```
http://localhost:8080
```

**Lưu ý**: Cần update port mapping trong docker-compose nếu muốn dùng port khác.

---

## 📊 KIỂM TRA HỆ THỐNG

### Kiểm Tra Port Đang Được Sử Dụng

```powershell
# Xem process nào đang dùng port 5000
netstat -ano | findstr :5000

# Hoặc
Get-NetTCPConnection -LocalPort 5000
```

### Kiểm Tra Docker Port Mapping

```powershell
docker port test-infrastructure-ckan-1
```

Kết quả mong đợi:
```
5000/tcp -> 0.0.0.0:5000
```

### Kiểm Tra CKAN Process

```powershell
docker exec test-infrastructure-ckan-1 ps aux | findstr ckan
```

---

## 🎨 NẾU VẪN KHÔNG ĐƯỢC

### Test Với Python HTTP Server

```powershell
# Tạo file test.html
echo "<h1>Test</h1>" > test.html

# Chạy HTTP server trên port 5001
python -m http.server 5001

# Truy cập: http://localhost:5001
```

Nếu test.html hiển thị được:
- ✅ Browser hoạt động bình thường
- ❌ Vấn đề nằm ở CKAN hoặc Docker

Nếu test.html KHÔNG hiển thị:
- ❌ Vấn đề nằm ở browser/network/firewall

---

## 💡 KHUYẾN NGHỊ

**Thử theo thứ tự:**

1. ✅ **Incognito mode** - Nhanh nhất
2. ✅ **Thử http://127.0.0.1:5000** - Thay vì localhost
3. ✅ **Clear browser cache** - Ctrl + Shift + Delete
4. ✅ **Thử browser khác** - Chrome, Firefox, Edge
5. ✅ **Tắt proxy** - Settings > Network
6. ✅ **Tắt antivirus tạm thời** - Test xem có phải do antivirus
7. ✅ **Flush DNS** - ipconfig /flushdns
8. ✅ **Thêm firewall rule** - Cho phép port 5000

---

## 📞 BÁO CÁO KẾT QUẢ

Sau khi thử, hãy cho tôi biết:

1. **Cách nào hoạt động?**
2. **Browser nào bạn đang dùng?**
3. **Có antivirus/firewall nào đang chạy?**
4. **Lỗi cụ thể là gì?** (ERR_CONNECTION_REFUSED, ERR_CONNECTION_TIMED_OUT, ...)

---

## 🎉 THÀNH CÔNG!

Khi truy cập được, bạn sẽ thấy:
- ✅ Trang chủ CKAN với theme màu tím
- ✅ Header gradient purple
- ✅ Search bar lớn
- ✅ Hero section

**Login tại**: http://localhost:5000/user/login
- Username: `admin`
- Password: `admin123`

---

**Hãy thử ngay và cho tôi biết kết quả!** 🚀


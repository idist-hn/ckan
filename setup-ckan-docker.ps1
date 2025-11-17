# Script Tự Động Setup CKAN trong Docker
# Tạo admin user và kích hoạt theme

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CKAN Docker Setup Script" -ForegroundColor Cyan
Write-Host "  - Create Admin User" -ForegroundColor Cyan
Write-Host "  - Activate Theme" -ForegroundColor Cyan
Write-Host "  - Start Web Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Bước 1: Kiểm tra Docker containers
Write-Host "[1/5] Checking Docker containers..." -ForegroundColor Yellow
$containers = docker ps --filter "name=test-infrastructure-ckan" --format "{{.Names}}"
if ($containers -match "test-infrastructure-ckan-1") {
    Write-Host "[OK] CKAN container is running" -ForegroundColor Green
} else {
    Write-Host "[ERROR] CKAN container not found!" -ForegroundColor Red
    Write-Host "Please start Docker containers first:" -ForegroundColor Yellow
    Write-Host "  cd test-infrastructure && docker-compose up -d" -ForegroundColor White
    exit 1
}

# Bước 2: Initialize database
Write-Host ""
Write-Host "[2/5] Initializing database..." -ForegroundColor Yellow
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini db init" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Database initialized" -ForegroundColor Green
} else {
    Write-Host "[INFO] Database may already be initialized" -ForegroundColor Cyan
}

# Bước 3: Tạo admin user
Write-Host ""
Write-Host "[3/5] Creating admin user..." -ForegroundColor Yellow
Write-Host "Username: admin" -ForegroundColor Cyan
Write-Host "Password: admin123" -ForegroundColor Cyan
Write-Host "Email: admin@localhost" -ForegroundColor Cyan

# Tạo script Python để tạo user
$pythonScript = @'
import ckan.model as model
from ckan.common import config

# Load config
from ckan.cli import load_config
conf = load_config('test-core-ci.ini')

# Initialize model
model.repo.init_db()

# Check if user exists
existing_user = model.User.get('admin')
if existing_user:
    print("User 'admin' already exists!")
    existing_user.sysadmin = True
    model.Session.commit()
    print("User 'admin' is now a sysadmin!")
else:
    # Create user
    user = model.User(name='admin', email='admin@localhost', password='admin123')
    model.Session.add(user)
    model.Session.commit()
    user.sysadmin = True
    model.Session.commit()
    print("Admin user created successfully!")
'@

# Save script to file
$pythonScript | Out-File -FilePath "create_user.py" -Encoding UTF8

# Copy to container
docker cp create_user.py test-infrastructure-ckan-1:/tmp/create_user.py

# Run script
docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && python /tmp/create_user.py"

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Admin user ready!" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Could not create user automatically" -ForegroundColor Yellow
    Write-Host "You can register manually at: http://localhost:5000/user/register" -ForegroundColor Cyan
}

# Bước 4: Kích hoạt theme
Write-Host ""
Write-Host "[4/5] Activating datagovsg_theme..." -ForegroundColor Yellow

# Kiểm tra xem theme đã được thêm vào config chưa
$configCheck = docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && grep 'datagovsg_theme' test-core-ci.ini"
if ($configCheck) {
    Write-Host "[OK] Theme already activated in config" -ForegroundColor Green
} else {
    Write-Host "[INFO] Adding theme to config..." -ForegroundColor Cyan
    docker exec test-infrastructure-ckan-1 bash -c "cd /usr/src && sed -i 's/ckan.plugins =/ckan.plugins = datagovsg_theme/' test-core-ci.ini"
    Write-Host "[OK] Theme added to config" -ForegroundColor Green
}

# Bước 5: Khởi động web server
Write-Host ""
Write-Host "[5/5] Starting CKAN web server..." -ForegroundColor Yellow
Write-Host "Server will be available at: http://localhost:5000" -ForegroundColor Green
Write-Host ""

# Kill existing CKAN processes
docker exec test-infrastructure-ckan-1 bash -c "pkill -f 'ckan.*run'" 2>$null

# Start server in background
docker exec -d test-infrastructure-ckan-1 bash -c "cd /usr/src && ckan -c test-core-ci.ini run --host 0.0.0.0 --port 5000"

Start-Sleep -Seconds 3

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Access CKAN at: http://localhost:5000" -ForegroundColor Green
Write-Host ""
Write-Host "Login credentials:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Password: admin123" -ForegroundColor White
Write-Host ""
Write-Host "Theme: Data.gov.sg (Purple theme)" -ForegroundColor Magenta
Write-Host ""
Write-Host "To view logs:" -ForegroundColor Yellow
Write-Host "  docker logs -f test-infrastructure-ckan-1" -ForegroundColor White
Write-Host ""
Write-Host "To stop server:" -ForegroundColor Yellow
Write-Host "  docker exec test-infrastructure-ckan-1 pkill -f 'ckan.*run'" -ForegroundColor White
Write-Host ""
Write-Host "Enjoy your new CKAN theme! 🎉" -ForegroundColor Green
Write-Host ""


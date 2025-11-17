# Script Tạo Admin User cho CKAN
# Tự động tạo tài khoản admin để login

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CKAN Admin User Creation" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Kích hoạt virtual environment
$venvPaths = @(
    "E:\cdsqg\venv\Scripts\Activate.ps1",
    "E:\cdsqg\ckan\venv\Scripts\Activate.ps1",
    "C:\ckan\venv\Scripts\Activate.ps1"
)

$venvFound = $false
foreach ($venvPath in $venvPaths) {
    if (Test-Path $venvPath) {
        Write-Host "[OK] Activating virtual environment..." -ForegroundColor Green
        & $venvPath
        $venvFound = $true
        break
    }
}

if (-not $venvFound) {
    Write-Host "[WARNING] Virtual environment not found!" -ForegroundColor Yellow
    Write-Host "Continuing without venv..." -ForegroundColor Yellow
}

# Chuyển đến thư mục CKAN
Set-Location "E:\cdsqg\ckan\sources\ckan"

Write-Host ""
Write-Host "Creating CKAN admin user..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Default credentials:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Email: admin@localhost" -ForegroundColor White
Write-Host "  Password: admin123" -ForegroundColor White
Write-Host ""
Write-Host "You can change these when prompted." -ForegroundColor Yellow
Write-Host ""

# Thử tạo admin
try {
    Write-Host "Method 1: Using 'ckan' command..." -ForegroundColor Cyan
    ckan -c development.ini sysadmin add admin email=admin@localhost password=admin123
    
    Write-Host ""
    Write-Host "[SUCCESS] Admin user created!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Login credentials:" -ForegroundColor Cyan
    Write-Host "  URL: http://localhost:5000" -ForegroundColor White
    Write-Host "  Username: admin" -ForegroundColor White
    Write-Host "  Password: admin123" -ForegroundColor White
    Write-Host ""
    
} catch {
    Write-Host "[FAILED] Method 1 failed, trying alternative..." -ForegroundColor Yellow
    
    try {
        Write-Host "Method 2: Using 'python -m ckan.cli'..." -ForegroundColor Cyan
        python -m ckan.cli -c development.ini sysadmin add admin email=admin@localhost password=admin123
        
        Write-Host ""
        Write-Host "[SUCCESS] Admin user created!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Login credentials:" -ForegroundColor Cyan
        Write-Host "  URL: http://localhost:5000" -ForegroundColor White
        Write-Host "  Username: admin" -ForegroundColor White
        Write-Host "  Password: admin123" -ForegroundColor White
        Write-Host ""
        
    } catch {
        Write-Host ""
        Write-Host "[ERROR] Failed to create admin user!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please try manually:" -ForegroundColor Yellow
        Write-Host "  ckan -c development.ini sysadmin add admin" -ForegroundColor White
        Write-Host ""
        Write-Host "Or create via web interface:" -ForegroundColor Yellow
        Write-Host "  1. Start server: ckan -c development.ini run" -ForegroundColor White
        Write-Host "  2. Visit: http://localhost:5000/user/register" -ForegroundColor White
        Write-Host "  3. Register an account" -ForegroundColor White
        Write-Host "  4. Make it admin: ckan -c development.ini sysadmin add username" -ForegroundColor White
        Write-Host ""
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


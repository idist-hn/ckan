# CKAN Development Server Startup Script
# Tự động khởi động CKAN với theme Data.gov.sg

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CKAN Development Server Startup" -ForegroundColor Cyan
Write-Host "  Theme: Data.gov.sg" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra virtual environment
$venvPaths = @(
    "E:\cdsqg\venv\Scripts\Activate.ps1",
    "E:\cdsqg\ckan\venv\Scripts\Activate.ps1",
    "C:\ckan\venv\Scripts\Activate.ps1",
    "..\venv\Scripts\Activate.ps1",
    "..\..\venv\Scripts\Activate.ps1"
)

$venvFound = $false
foreach ($venvPath in $venvPaths) {
    if (Test-Path $venvPath) {
        Write-Host "[OK] Found virtual environment: $venvPath" -ForegroundColor Green
        Write-Host "Activating virtual environment..." -ForegroundColor Yellow
        & $venvPath
        $venvFound = $true
        break
    }
}

if (-not $venvFound) {
    Write-Host "[WARNING] Virtual environment not found!" -ForegroundColor Red
    Write-Host "Trying to run without virtual environment..." -ForegroundColor Yellow
    Write-Host ""
}

# Chuyển đến thư mục CKAN
$ckanDir = "E:\cdsqg\ckan\sources\ckan"
if (Test-Path $ckanDir) {
    Set-Location $ckanDir
    Write-Host "[OK] Changed to CKAN directory: $ckanDir" -ForegroundColor Green
} else {
    Write-Host "[ERROR] CKAN directory not found: $ckanDir" -ForegroundColor Red
    Write-Host "Please update the path in this script." -ForegroundColor Yellow
    exit 1
}

# Kiểm tra file config
if (-not (Test-Path "development.ini")) {
    Write-Host "[ERROR] development.ini not found!" -ForegroundColor Red
    Write-Host "Please create development.ini first." -ForegroundColor Yellow
    exit 1
}

Write-Host "[OK] Found development.ini" -ForegroundColor Green
Write-Host ""

# Kiểm tra theme trong config
$configContent = Get-Content "development.ini" -Raw
if ($configContent -match "datagovsg_theme") {
    Write-Host "[OK] Theme 'datagovsg_theme' is enabled in config" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Theme 'datagovsg_theme' not found in config!" -ForegroundColor Yellow
    Write-Host "Please add 'datagovsg_theme' to ckan.plugins in development.ini" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Starting CKAN Server..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server will be available at: http://localhost:5000" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Thử các cách khởi động khác nhau
Write-Host "Attempting to start CKAN..." -ForegroundColor Yellow

# Cách 1: ckan command
try {
    Write-Host "Method 1: Using 'ckan' command..." -ForegroundColor Cyan
    ckan -c development.ini run
} catch {
    Write-Host "[FAILED] Method 1 failed" -ForegroundColor Red
    
    # Cách 2: python -m ckan.cli
    try {
        Write-Host "Method 2: Using 'python -m ckan.cli'..." -ForegroundColor Cyan
        python -m ckan.cli -c development.ini run
    } catch {
        Write-Host "[FAILED] Method 2 failed" -ForegroundColor Red
        
        # Cách 3: paster
        try {
            Write-Host "Method 3: Using 'paster'..." -ForegroundColor Cyan
            paster serve development.ini
        } catch {
            Write-Host "[FAILED] All methods failed!" -ForegroundColor Red
            Write-Host ""
            Write-Host "Please try manually:" -ForegroundColor Yellow
            Write-Host "1. Activate virtual environment" -ForegroundColor White
            Write-Host "2. Run: ckan -c development.ini run" -ForegroundColor White
            Write-Host ""
            Write-Host "Or check START_SERVER.md for detailed instructions" -ForegroundColor Yellow
            exit 1
        }
    }
}


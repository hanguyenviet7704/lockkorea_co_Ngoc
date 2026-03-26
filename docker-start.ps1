# PowerShell script to start Docker containers for LockerKorea project
# Checks Docker Desktop status and starts required containers

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LockerKorea Docker Container Manager" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is installed
Write-Host "Checking Docker installation..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Docker not found"
    }
    Write-Host "Docker found: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Docker is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Docker Desktop from: https://docs.docker.com/desktop/install/windows-install/" -ForegroundColor Yellow
    exit 1
}

# Check if Docker Desktop is running
Write-Host "Checking Docker Desktop status..." -ForegroundColor Yellow
try {
    docker info 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Docker Desktop not running"
    }
    Write-Host "Docker Desktop is running" -ForegroundColor Green
} catch {
    Write-Host "WARNING: Docker Desktop is not running!" -ForegroundColor Red
    Write-Host "Attempting to start Docker Desktop..." -ForegroundColor Yellow
    
    # Try to start Docker Desktop
    $dockerDesktopPath = "${env:ProgramFiles}\Docker\Docker\Docker Desktop.exe"
    if (Test-Path $dockerDesktopPath) {
        Start-Process $dockerDesktopPath
        Write-Host "Waiting for Docker Desktop to start (this may take 30-60 seconds)..." -ForegroundColor Yellow
        
        $maxWait = 60
        $waited = 0
        while ($waited -lt $maxWait) {
            Start-Sleep -Seconds 2
            $waited += 2
            docker info 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Docker Desktop is now running!" -ForegroundColor Green
                break
            }
            Write-Host "." -NoNewline -ForegroundColor Yellow
        }
        
        if ($waited -ge $maxWait) {
            Write-Host ""
            Write-Host "ERROR: Docker Desktop failed to start within $maxWait seconds" -ForegroundColor Red
            Write-Host "Please start Docker Desktop manually and try again" -ForegroundColor Yellow
            exit 1
        }
    } else {
        Write-Host "ERROR: Docker Desktop not found at expected location" -ForegroundColor Red
        Write-Host "Please start Docker Desktop manually and try again" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host ""
Write-Host "Starting containers..." -ForegroundColor Yellow

# Start MySQL container
Write-Host "Starting mysql8-container..." -ForegroundColor Cyan
docker compose -f ./deployment.yaml up -d mysql8-container
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to start mysql8-container" -ForegroundColor Red
    exit 1
}

# Start phpMyAdmin container
Write-Host "Starting phpmyadmin8-container..." -ForegroundColor Cyan
docker compose -f ./deployment.yaml up -d phpmyadmin8-container
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to start phpmyadmin8-container" -ForegroundColor Red
    exit 1
}

# Start Chroma container
Write-Host "Starting chroma-container..." -ForegroundColor Cyan
docker compose -f ./deployment.yaml up -d chroma-container
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to start chroma-container" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Containers started successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Container Status:" -ForegroundColor Cyan
docker compose -f ./deployment.yaml ps
Write-Host ""
Write-Host "Useful commands:" -ForegroundColor Yellow
Write-Host "  View logs:    docker compose -f ./deployment.yaml logs -f [container-name]"
Write-Host "  Stop all:     docker compose -f ./deployment.yaml down"
Write-Host "  Restart:      docker compose -f ./deployment.yaml restart [container-name]"
Write-Host ""

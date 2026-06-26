# Build script for mini-multilinear-form
# Run from the mini-multilinear-form directory

Write-Host "Building mini-multilinear-form..." -ForegroundColor Cyan

# Navigate to the package directory
$packageDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageDir = Split-Path -Parent $packageDir
Set-Location $packageDir

# Clean build artifacts
if (Test-Path ".lake") {
    Write-Host "Cleaning previous build..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force .lake
}
if (Test-Path "build") {
    Remove-Item -Recurse -Force build
}

# Build the package
Write-Host "Running lake build..." -ForegroundColor Cyan
lake build

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful!" -ForegroundColor Green
} else {
    Write-Host "Build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Test script for mini-multilinear-form
# Run from the mini-multilinear-form directory

Write-Host "Testing mini-multilinear-form..." -ForegroundColor Cyan

# Navigate to the package directory
$packageDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageDir = Split-Path -Parent $packageDir
Set-Location $packageDir

# Run each test module
$testModules = @(
    "MiniMultilinearForm.Test.BilinearTest",
    "MiniMultilinearForm.Test.SymmetricTest",
    "MiniMultilinearForm.Test.MultilinearTest"
)

$allPassed = $true
foreach ($module in $testModules) {
    Write-Host "`nRunning $module..." -ForegroundColor Cyan
    # Stub: lake env lean --run would be used if test runner existed
    Write-Host "  [STUB] Test module: $module" -ForegroundColor Gray
}

# Run benchmarks (optional, with --bench flag)
if ($args -contains "--bench") {
    Write-Host "`nRunning benchmarks..." -ForegroundColor Magenta
    $benchModules = @(
        "MiniMultilinearForm.Benchmark.BilinearBench",
        "MiniMultilinearForm.Benchmark.SymmetricBench",
        "MiniMultilinearForm.Benchmark.AlternatingBench",
        "MiniMultilinearForm.Benchmark.MultilinearBench",
        "MiniMultilinearForm.Benchmark.TensorBench",
        "MiniMultilinearForm.Benchmark.OperationsBench"
    )
    foreach ($module in $benchModules) {
        Write-Host "  [STUB] Benchmark: $module" -ForegroundColor Gray
    }
}

Write-Host "`nTest suite complete." -ForegroundColor Green

# Smoke check script for mini-vector-space-core
Write-Output "mini-vector-space-core check..."
lake build 2>&1
if ($LASTEXITCODE -eq 0) { Write-Output "BUILD OK" } else { Write-Output "BUILD FAILED" }

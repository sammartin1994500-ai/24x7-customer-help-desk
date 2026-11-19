# Right-click -> Run with PowerShell, or run in terminal:
# powershell -ExecutionPolicy Bypass -File .\DOWNLOAD_ALL_PHOTOS.ps1
$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$folder = Join-Path $root "public\images"
New-Item -ItemType Directory -Force -Path $folder | Out-Null
$items = Get-Content -Raw (Join-Path $root "photo-sources.json") | ConvertFrom-Json
$found = @{}
foreach ($item in $items) {
  $target = Join-Path $folder $item.filename
  try {
    if (-not (Test-Path $target) -or (Get-Item $target).Length -eq 0) {
      Invoke-WebRequest -Uri $item.url -OutFile $target -TimeoutSec 45 -ErrorAction Stop
    }
    if ((Get-Item $target).Length -gt 0) {
      $found[$item.filename] = $true
      Write-Host "OK: $($item.filename)" -ForegroundColor Green
    }
  } catch {
    Write-Warning "Could not download $($item.filename): $($_.Exception.Message)"
    if ((Test-Path $target) -and (Get-Item $target).Length -eq 0) { Remove-Item $target }
  }
}
$manifest = Join-Path $root "src\components\invitation\photo-local.json"
$found | ConvertTo-Json -Depth 3 | Set-Content -Path $manifest -Encoding utf8
Write-Host "Downloaded $($found.Count) of $($items.Count) photos. Restart npm run dev."

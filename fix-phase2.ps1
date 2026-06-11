# fix-phase2.ps1 — Déplace les fichiers Phase 2 vers leurs bons dossiers
# Lancer depuis la racine du repo :
#   cd C:\Users\bbrod\Projets\Quickshell-Hyprland
#   .\fix-phase2.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = $PSScriptRoot

# ── Fichiers ControlCenter ────────────────────────────────
$cc = Join-Path $root "modules\ControlCenter"
foreach ($f in @("ControlCenter.qml","CCToggle.qml","CCSlider.qml","CCNetworkInfo.qml","CCActionButton.qml")) {
    $src = Join-Path $root $f
    $dst = Join-Path $cc $f
    if (Test-Path $src) {
        Move-Item -Force $src $dst
        Write-Host "  moved  $f  →  modules\ControlCenter\" -ForegroundColor Green
    } else {
        Write-Host "  skip   $f  (not found at root)" -ForegroundColor Yellow
    }
}

# ── Fichiers services ─────────────────────────────────────
$svc = Join-Path $root "services"
foreach ($f in @("AudioService.qml","BrightnessService.qml","WifiService.qml","BluetoothService.qml","NightService.qml","qmldir")) {
    $src = Join-Path $root $f
    $dst = Join-Path $svc $f
    if (Test-Path $src) {
        Move-Item -Force $src $dst
        Write-Host "  moved  $f  →  services\" -ForegroundColor Green
    } else {
        Write-Host "  skip   $f  (not found at root)" -ForegroundColor Yellow
    }
}

# ── Bar.qml → modules\Bar\ ────────────────────────────────
$barSrc = Join-Path $root "Bar.qml"
$barDst = Join-Path $root "modules\Bar\Bar.qml"
if (Test-Path $barSrc) {
    Move-Item -Force $barSrc $barDst
    Write-Host "  moved  Bar.qml  →  modules\Bar\" -ForegroundColor Green
}

Write-Host ""
Write-Host "Vérification finale :" -ForegroundColor Cyan
Get-ChildItem $root -File | Select-Object Name | ForEach-Object { Write-Host "  [racine] $($_.Name)" }
Get-ChildItem "$root\modules\ControlCenter" -File | Select-Object Name | ForEach-Object { Write-Host "  [ControlCenter] $($_.Name)" }
Get-ChildItem "$root\services" -File | Select-Object Name | ForEach-Object { Write-Host "  [services] $($_.Name)" }
Get-ChildItem "$root\modules\Bar" -File | Select-Object Name | ForEach-Object { Write-Host "  [Bar] $($_.Name)" }

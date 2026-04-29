Write-Host "===============================" -ForegroundColor Green
Write-Host "   EliteX All-In-One Booster" -ForegroundColor Green
Write-Host "===============================" -ForegroundColor Green

# ================= CLEAN =================
Write-Host "Cleaning temp files..." -ForegroundColor Yellow
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# ================= SERVICES =================
Write-Host "Stopping unnecessary services..." -ForegroundColor Yellow

$services = @("SysMain","DiagTrack","WSearch")
foreach ($s in $services) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
}

# ================= NETWORK =================
Write-Host "Optimizing network..." -ForegroundColor Yellow
ipconfig /flushdns | Out-Null
netsh int tcp set global autotuninglevel=disabled | Out-Null

# ================= FPS BOOST =================
Write-Host "Setting process priority..." -ForegroundColor Yellow

Get-Process -Name "HD-Player" -ErrorAction SilentlyContinue | ForEach-Object {
    $_.PriorityClass = "High"
}

Get-Process -Name "dnplayer" -ErrorAction SilentlyContinue | ForEach-Object {
    $_.PriorityClass = "High"
}

# ================= INPUT BOOST =================
Write-Host "Optimizing mouse input..." -ForegroundColor Yellow

Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseSpeed -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold1 -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold2 -Value "0"

# ================= VISUAL BOOST =================
Write-Host "Disabling animations..." -ForegroundColor Yellow

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" `
-Name VisualFXSetting -PropertyType DWord -Value 2 -Force | Out-Null

# ================= POWER =================
Write-Host "Enabling high performance mode..." -ForegroundColor Yellow
powercfg -setactive SCHEME_MIN | Out-Null

# ================= DONE =================
Write-Host "===============================" -ForegroundColor Green
Write-Host "   BOOST COMPLETE 🚀" -ForegroundColor Green
Write-Host "===============================" -ForegroundColor Green

Pause
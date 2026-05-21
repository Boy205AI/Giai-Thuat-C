Write-Host "=== ĐANG CÀI ĐẶT VISUAL STUDIO CODE ===" -ForegroundColor Green

# Sử dụng winget để tự động tải và cài đặt VS Code
winget install -e --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements --silent

Write-Host "Cài đặt Visual Studio Code hoàn tất!" -ForegroundColor Cyan
 

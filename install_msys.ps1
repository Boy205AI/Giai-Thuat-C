# Lưu file này với tên: Install-MSYS2-Config.ps1

Write-Host "=== 1. ĐANG CÀI ĐẶT MSYS2 ===" -ForegroundColor Green
winget install -e --id MSYS2.MSYS2 --accept-package-agreements --accept-source-agreements --silent

Write-Host "=== 2. THIẾT LẬP BIẾN MÔI TRƯỜNG PATH ===" -ForegroundColor Green
# Đường dẫn mặc định của công cụ MinGW64 bên trong MSYS2
$msysMinGW = "C:\msys64\mingw64\bin"

# Lấy giá trị biến PATH hiện tại của hệ thống
$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")

# Kiểm tra xem PATH đã chứa MSYS2 chưa, nếu chưa thì tiến hành thêm
if ($machinePath -notmatch [regex]::Escape($msysMinGW)) {
    $newPath = $machinePath + ";" + $msysMinGW
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "Đã thêm $msysMinGW vào biến PATH hệ thống thành công!" -ForegroundColor Cyan
} else {
    Write-Host "Đường dẫn $msysMinGW đã tồn tại trong PATH, bỏ qua bước này." -ForegroundColor Yellow
}

Write-Host "=== 3. CÀI ĐẶT TRÌNH BIÊN DỊCH C/C++ (GCC & GDB) ===" -ForegroundColor Green
$bashPath = "C:\msys64\usr\bin\bash.exe"

# Đợi vài giây để đảm bảo MSYS2 đã khởi tạo cấu trúc thư mục xong sau khi cài đặt
Start-Sleep -Seconds 5

if (Test-Path $bashPath) {
    # Gọi bash của MSYS2 để chạy lệnh pacman tải bộ gcc và gdb (không cần xác nhận Y/N)
    Start-Process -FilePath $bashPath -ArgumentList "-lc 'pacman -S --noconfirm --needed mingw-w64-x86_64-gcc mingw-w64-x86_64-gdb'" -Wait
    Write-Host "Đã cài đặt xong bộ trình biên dịch C/C++ cho MSYS2!" -ForegroundColor Cyan
} else {
    Write-Host "Không tìm thấy đường dẫn MSYS2, vui lòng khởi động lại máy và kiểm tra!" -ForegroundColor Red
}

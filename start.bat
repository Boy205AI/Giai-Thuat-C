@echo off
title Setup Môi Trường C++ UCRT64 Tự Động
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ CHO VS CODE
echo ===================================================

set "CURRENT_DIR=%~dp0"
:: [QUAN TRONG] Thay link duoi day bang link file ucrt64.zip o muc Releases cua ban
set "COMPILER_URL=https://github.com/TenCuaBan/GiaiThuat-C/releases/download/v1.0/ucrt64.zip"
set "ZIP_FILE=ucrt64.zip"

:: 1. Kiem tra xem da tai chua, neu co roi thi bo qua de do mat thoi gian
if exist "%CURRENT_DIR%ucrt64\bin\g++.exe" (
    echo [OK] Trinh bien dich UCRT64 da ton tai tren may!
    goto :setup_env
)

:: 2. Tai file tu GitHub bang lenh cURL
echo [1/3] Dang tai trinh bien dich tu GitHub... (Se mat vai phut tuy mang truong)
curl -L -o "%ZIP_FILE%" "%COMPILER_URL%"

:: 3. Giai nen bang PowerShell (Windows 10/11 nao cung co)
echo [2/3] Tai xong! Dang giai nen file...
powershell -command "Expand-Archive -Force '%ZIP_FILE%' '%CURRENT_DIR%'"

:: Xoa file zip cho nhe may sau khi giai nen xong
del "%ZIP_FILE%"

:setup_env
:: 4. Thiet lap bien moi truong
echo [3/3] Dang cau hinh bien moi truong cho VS Code...
setx MY_COMPILER "%CURRENT_DIR%ucrt64\bin"
setx PATH "%CURRENT_DIR%ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT! MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
:: Doi 3 giay de Windows nhan bien moi truong roi tu dong mo VS Code tai thu muc hien tai
timeout /t 3 >nul
code .
exit
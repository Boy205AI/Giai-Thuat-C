@echo off
title Setup Môi Trường C++ UCRT64 Tự Động
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ CHO VS CODE
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "COMPILER_URL=https://github.com/Boy205AI/Giai-Thuat-C/releases/download/v1.0/ucrt64.zip"
set "ZIP_FILE=ucrt64.zip"

if exist "%CURRENT_DIR%ucrt64\bin\g++.exe" (
    echo [OK] Trinh bien dich UCRT64 da ton tai tren may!
    goto :setup_env
)

echo [1/3] Dang tai trinh bien dich tu GitHub... (Se mat vai phut tuy mang truong)
curl -L -o "%ZIP_FILE%" "%COMPILER_URL%"

echo [2/3] Tai xong! Dang giai nen file...
powershell -command "Expand-Archive -Force '%ZIP_FILE%' '%CURRENT_DIR%'"

del "%ZIP_FILE%"

echo [3/3] Dang cau hinh bien moi truong cho VS Code...
setx MY_COMPILER "%CURRENT_DIR%ucrt64\bin"
setx PATH "%CURRENT_DIR%ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT! MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================

timeout /t 3 >nul
code .
exit

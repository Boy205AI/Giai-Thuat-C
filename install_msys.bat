@echo off
title Bo Cai Dat Tu Dong MSYS2 + G++ + GDB cho moi may tinh
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TUONG THICH CAO
echo ===================================================

:: [NANG CAP 1] Ep script luon chay tai dung thu muc chua no 
:: (Khac phuc triet de loi khi nguoi dung "Run as Administrator")
cd /d "%~dp0"

:: Kiem tra cac cong cu can thiet
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo [Loi] Khong tim thay 'curl'. Vui long cap nhat Windows hoac cai dat curl.
    pause
    exit /b 1
)

where code >nul 2>nul
if %errorlevel% neq 0 (
    echo [Loi] Khong tim thay lenh 'code'. Vui long cai dat VS Code va them vao PATH truoc!
    pause
    exit /b 1
)

set "MSYS_DIR=%CD%\msys64"
set "MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe"
set "INSTALLER=msys2-base-latest.sfx.exe"

if exist "%MSYS_DIR%\ucrt64\bin\gdb.exe" (
    echo [OK] Trinh bien dich va go loi da ton tai tren may nay!
    goto :install_extensions
)

echo.
echo [1/5] Dang tai MSYS2 Base phien ban moi nhat...
curl -L -o "%INSTALLER%" "%MSYS_URL%"

echo.
echo [2/5] Dang giai nen va khoi tao he thong MSYS2...
"%INSTALLER%" -y
del "%INSTALLER%"

echo.
echo [3/5] Dang chay lan dau va cap nhat he thong loi (Core Update)...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc " "
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"

echo.
echo [4/5] Dang tai va cai dat G++ va GDB...
:: [NANG CAP 2] Vong lap tu dong thu lai 3 lan neu gap loi mang (Loi 403, Timeout...)
set /a retry_count=1

:retry_pacman
echo Dang tai goi lan thu %retry_count%/3...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman -Syy --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb"

if %errorlevel% neq 0 (
    if %retry_count% lss 3 (
        set /a retry_count+=1
        echo [Canh bao] Tai that bai do su co may chu mạng. Dang tu dong doi 5 giay de thu lai...
        timeout /t 5 >nul
        goto :retry_pacman
    ) else (
        echo [Loi] Khong the tai C++ sau 3 lan thu do loi mang. Vui long kiem tra Internet va thu lai sau!
        pause
        exit /b 1
    )
)
echo [OK] Da tai va cai dat xong G++ va GDB!

:install_extensions
echo.
echo [5/5] Dang cai dat Extensions cho VS Code...
cmd /c code --install-extension ms-vscode.cpptools --force
cmd /c code --install-extension formulahendry.code-runner --force
cmd /c code --install-extension zhuangtongfa.Material-theme --force

echo.
echo [*] Dang cau hinh bien moi truong PATH cho Windows...
setx MY_COMPILER "%MSYS_DIR%\ucrt64\bin" >nul

:: Su dung PowerShell de them vao User PATH an toan, tranh loi 1024 ky tu hoac trung lap
powershell -Command "$userPath = [Environment]::GetEnvironmentVariable('Path', 'User'); $newPath = '%MSYS_DIR%\ucrt64\bin'; if ($userPath -notmatch [regex]::Escape($newPath)) { $finalPath = $userPath + ';' + $newPath; [Environment]::SetEnvironmentVariable('Path', $finalPath, 'User') }"

:: Apply PATH vao session CMD hien tai de VS Code nhan dien ngay lap tuc
set "PATH=%MSYS_DIR%\ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT! CAI DAT THANH CONG TREN MAY NAY.
echo   MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit

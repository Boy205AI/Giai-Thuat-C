@echo off
title Setup MSYS2 + G++ + GDB + VS Code Extensions
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TU MSYS2
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

:: --- PHAN 1: KIEM TRA VA CAI DAT VS CODE ---
echo [*] Dang kiem tra Visual Studio Code...
where code >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [!] Khong tim thay VS Code trong he thong.
    echo [>] Dang tai VS Code moi nhat tu trang chu...
    :: Link tai ban User Installer x64 on dinh
    curl -L -o "vscode_user_setup.exe" "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    
    echo [>] Dang cai dat VS Code am tham (Silent Install)...
    :: /verysilent: khong hien cua so, /mergetasks=!runcode,addtopath: them vao PATH va khong tu mo sau khi cai
    start /wait vscode_user_setup.exe /verysilent /mergetasks=!runcode,addtopath
    
    del "vscode_user_setup.exe"
    echo [OK] Da cai dat VS Code xong!
    
    :: Cap nhat PATH tam thoi cho cua so CMD nay de nhan lenh 'code' ngay lap tuc
    set "PATH=%LocalAppData%\Programs\Microsoft VS Code\bin;%PATH%"
) else (
    echo [OK] VS Code da duoc cai dat san.
)

:: --- PHAN 2: THIET LAP MSYS2 (G++ & GDB) ---
set "MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-base-x86_64-20240113.sfx.exe"
set "INSTALLER=msys2-base.sfx.exe"

if exist "%MSYS_DIR%\ucrt64\bin\gdb.exe" (
    echo [OK] Trinh bien dich va go loi da ton tai tren may!
    goto :install_extensions
)

echo.
echo [1/4] Dang tai MSYS2 Base...
curl -L -o "%INSTALLER%" "%MSYS_URL%"

echo.
echo [2/4] Dang khoi tao he thong MSYS2...
"%INSTALLER%" -y
del "%INSTALLER%"

echo.
echo [3/4] Dang ket noi may chu MSYS2.org de tai G++ va GDB...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman -Sy --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb"

:install_extensions
:: --- PHAN 3: CAI DAT EXTENSIONS ---
echo.
echo [4/4] Dang cai dat Extensions cho VS Code...
:: Su dung call code de dam bao lenh chay on dinh
call code --install-extension ms-vscode.cpptools --force
call code --install-extension formulahendry.code-runner --force

:: --- PHAN 4: CAU HINH BIEN MOI TRUONG ---
echo.
echo [*] Dang cau hinh bien moi truong...
setx MY_COMPILER "%MSYS_DIR%\ucrt64\bin"
setx PATH "%MSYS_DIR%\ucrt64\bin;%PATH%"

set "MY_COMPILER=%MSYS_DIR%\ucrt64\bin"
set "PATH=%MSYS_DIR%\ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT! MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit

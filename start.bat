@echo off
title Setup MSYS2 + G++ + GDB + VS Code Extensions
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TU MSYS2
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

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

echo.
echo [4/4] Dang kiem tra va cai dat Extensions cho VS Code...

set "VS_CODE_CMD=code"

where code >nul 2>nul
if %ERRORLEVEL% neq 0 (
    if exist "%LocalAppData%\Programs\Microsoft VS Code\bin\code.cmd" set "VS_CODE_CMD=%LocalAppData%\Programs\Microsoft VS Code\bin\code.cmd"
    if exist "C:\Program Files\Microsoft VS Code\bin\code.cmd" set "VS_CODE_CMD=C:\Program Files\Microsoft VS Code\bin\code.cmd"
    if exist "C:\Program Files (x86)\Microsoft VS Code\bin\code.cmd" set "VS_CODE_CMD=C:\Program Files (x86)\Microsoft VS Code\bin\code.cmd"
)

if defined VS_CODE_CMD (
    echo [+] Da xac dinh duoc vi tri VS Code. Dang cai dat...
    
    call "%VS_CODE_CMD%" --install-extension ms-vscode.cpptools --force
    call "%VS_CODE_CMD%" --install-extension formulahendry.code-runner --force
    
    echo [OK] Da gui lenh cai dat. Dang doi 5 giay de he thong ghi nhan...
    timeout /t 5 >nul
) else (
    echo [!] CANH BAO: Khong tim thay VS Code tren he thong.
    echo Ban hay tu mo VS Code va cài Extensions thu cong nhe!
)

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

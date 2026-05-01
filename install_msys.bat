@echo off
title Setup MSYS2 + G++ + GDB + VS Code Extensions
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TU MSYS2
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

:: [1] Thay doi URL de luon tai ban MSYS2 Base moi nhat
set "MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe"
set "INSTALLER=msys2-base-latest.sfx.exe"

if exist "%MSYS_DIR%\ucrt64\bin\gdb.exe" (
    echo [OK] Trinh bien dich va go loi da ton tai tren may!
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
:: [2] Chay bash lan dau de khoi tao ho so nguoi dung va sinh khoa GPG
call "%MSYS_DIR%\usr\bin\bash.exe" -lc " "
:: [3] Cap nhat he thong loi lan 1 (pacman, bash, keyring)
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"
:: [4] Cap nhat cac goi thong thuong lan 2 (dam bao tat ca deu phien ban moi nhat)
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"

echo.
echo [4/5] Dang tai va cai dat G++ va GDB...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman -Sy --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb"

:install_extensions
echo.
echo [5/5] Dang cai dat Extensions cho VS Code...
call code --install-extension ms-vscode.cpptools --force
call code --install-extension formulahendry.code-runner --force
call code --install-extension zhuangtongfa.Material-theme --force

echo.
echo [*] Dang cau hinh bien moi truong...
setx MY_COMPILER "%MSYS_DIR%\ucrt64\bin"
setx PATH "%MSYS_DIR%\ucrt64\bin;%PATH%"

set "MY_COMPILER=%MSYS_DIR%\ucrt64\bin"
set "PATH=%MSYS_DIR%\ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT!
echo   MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit

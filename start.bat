@echo off
title Setup MSYS2 + G++ + VS Code Extensions
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TU MSYS2
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

set "MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-base-x86_64-20240113.sfx.exe"
set "INSTALLER=msys2-base.sfx.exe"

if exist "%MSYS_DIR%\ucrt64\bin\g++.exe" (
    echo [OK] Trinh bien dich g++ da ton tai tren may!
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
echo [3/4] Dang chay Pacman de tai g++ (Co the mat 3-5 phut tuy mang)...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc"

:install_extensions
echo.
echo [4/4] Dang cai dat Extensions cho VS Code...
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
echo   HOAN TAT! MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit

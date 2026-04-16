@echo off
title Go bo moi truong C++ (MSYS2 - UCRT64)
echo ===================================================
echo     DANG GO BO MOI TRUONG VA DON DEP HE THONG
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

:: 1. Go bo Extensions cua VS Code
echo.
echo [1/3] Dang go bo VS Code Extensions...
:: Go dung nhung extension ma start.bat da cai
call code --uninstall-extension ms-vscode.cpptools
call code --uninstall-extension formulahendry.code-runner
call code --uninstall-extension zhuangtongfa.Material-theme

:: 2. Xoa thu muc msys64 (Toan bo Compiler va Pacman)
echo.
echo [2/3] Dang xoa bo thu muc MSYS2 (msys64)...
if exist "%MSYS_DIR%" (
    :: Lenh xoa toan bo thu muc vinh vien
    rmdir /s /q "%MSYS_DIR%"
    echo [OK] Da xoa thu muc msys64.
) else (
    echo [!] Khong tim thay thu muc msys64 de xoa.
)

:: Xoa file cai dat neu con sot lai
if exist "%CURRENT_DIR%msys2-base.sfx.exe" del "%CURRENT_DIR%msys2-base.sfx.exe"

:: 3. Go bo bien moi truong
echo.
echo [3/3] Dang xoa bien moi truong MY_COMPILER...
:: Xoa key trong Registry cua Windows
reg delete "HKCU\Environment" /v MY_COMPILER /f >nul 2>&1

echo.
echo ===================================================
echo   HOAN TAT! May tinh phong may da duoc don dep.
echo   Luu y: Bien PATH se tu dong het hieu luc o lan khoi dong sau.
echo ===================================================
pause
exit

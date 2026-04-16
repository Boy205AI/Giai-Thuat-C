@echo off
title Go bo moi truong C++ (UCRT64)
echo ===================================================
echo     DANG GO BO MOI TRUONG VA DON DEP HE THONG
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

echo.
echo [1/3] Dang go bo VS Code Extensions...
call code --uninstall-extension ms-vscode.cpptools
call code --uninstall-extension formulahendry.code-runner
call code --uninstall-extension zhuangtongfa.Material-theme

echo.
echo [2/3] Dang xoa bo thu muc MSYS2 (msys64)...
if exist "%MSYS_DIR%" (
    rmdir /s /q "%MSYS_DIR%"
    echo [OK] Da xoa thu muc msys64.
) else (
    echo [!] Khong tim thay thu muc msys64.
)

echo.
echo [3/3] Dang xoa bien moi truong MY_COMPILER...
reg delete "HKCU\Environment" /v MY_COMPILER /f >nul 2>&1

echo.
echo ===================================================
echo   HOAN TAT! He thong da duoc don dep sach se.
echo   Luu y: Bien PATH se tu dong het hieu luc o lan dang nhap sau.
echo ===================================================
pause
exit

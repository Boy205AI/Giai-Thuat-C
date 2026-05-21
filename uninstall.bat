@echo off
title Go bo moi truong C++ (MSYS2 - UCRT64)
echo ===================================================
echo     DANG GO BO MOI TRUONG VA DON DEP HE THONG
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

echo.
echo [1/3] Dang go bo VS Code Extensions...
call code --uninstall-extension ms-vscode.cpptools
call code --uninstall-extension formulahendry.code-runner

echo.
echo [2/3] Dang xoa bo thu muc MSYS2 (msys64)...
if exist "%MSYS_DIR%" (
    rmdir /s /q "%MSYS_DIR%"
    echo [OK] Da xoa thu muc msys64.
)

if exist "%CURRENT_DIR%msys2-base.sfx.exe" del "%CURRENT_DIR%msys2-base.sfx.exe"
if exist "%CURRENT_DIR%vscode_setup.exe" del "%CURRENT_DIR%vscode_setup.exe"

echo.
echo [3/3] Dang xoa bien moi truong MY_COMPILER...
reg delete "HKCU\Environment" /v MY_COMPILER /f >nul 2>&1

echo.
echo ===================================================
echo   HOAN TAT! May tinh phong may da duoc don dep.
echo ===================================================
pause
exit

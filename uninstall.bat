@echo off
title Go bo moi truong C++ (MSYS2 - UCRT64)
echo ===================================================
echo     DANG GO BO MOI TRUONG VA DON DEP HE THONG
echo ===================================================

setlocal enabledelayedexpansion
set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

echo.
echo [0/5] Dung cac tien trinh MSYS2 neu dang chay...
tasklist /FI "IMAGENAME eq bash.exe" 2>NUL | find /I "bash.exe" >NUL
if %ERRORLEVEL% equ 0 (
    echo [Thong bao] Phat hien bash.exe dang chay. Dang ket thuc tien trinh...
    taskkill /IM bash.exe /F >nul 2>&1
)
tasklist /FI "IMAGENAME eq msys2.exe" 2>NUL | find /I "msys2.exe" >NUL
if %ERRORLEVEL% equ 0 (
    taskkill /IM msys2.exe /F >nul 2>&1
)

echo.
echo [1/5] Goi go bo VS Code Extensions (neu co)...
where.exe code >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo [Thong bao] Dang go C/C++ Tools, Code Runner, Theme...
    cmd /c code --uninstall-extension ms-vscode.cpptools --force >nul 2>&1 || echo [Warn] Khong the go cpptools
    cmd /c code --uninstall-extension formulahendry.code-runner --force >nul 2>&1 || echo [Warn] Khong the go code-runner
    cmd /c code --uninstall-extension zhuangtongfa.material-theme --force >nul 2>&1 || echo [Warn] Khong the go theme
) else (
    call :find_vscode_bin
    if defined VSCODE_BIN (
        echo [Thong bao] Tim thay code.cmd tai !VSCODE_BIN!, dang go extensions...
        pushd "!VSCODE_BIN!" >nul 2>&1
        if exist code.cmd (
            cmd /c code.cmd --uninstall-extension ms-vscode.cpptools --force >nul 2>&1 || echo [Warn] Khong the go cpptools
            cmd /c code.cmd --uninstall-extension formulahendry.code-runner --force >nul 2>&1 || echo [Warn] Khong the go code-runner
            cmd /c code.cmd --uninstall-extension zhuangtongfa.material-theme --force >nul 2>&1 || echo [Warn] Khong the go theme
        )
        popd >nul 2>&1
    ) else (
        echo [Thong bao] Khong tim thay 'code' CLI. Bo qua buoc go Extension.
    )
)

echo.
echo [2/5] Xoa bo thu muc MSYS2 (msys64)...
if exist "%MSYS_DIR%" (
    echo [Thong bao] Dang xoa: %MSYS_DIR% (co the can thoi gian)
    rmdir /S /Q "%MSYS_DIR%" >nul 2>&1
    if exist "%MSYS_DIR%" (
        echo [Loi] Khong the xoa %MSYS_DIR%. Vui long dong tat cac tien trinh va thu tay.
    ) else (
        echo [OK] Da xoa thu muc msys64.
    )
) else (
    echo [Thong bao] Khong tim thay thu muc msys64, bo qua.
)

echo.
echo [3/5] Xoa cac file installer tam thoi trong thu muc hien tai...
if exist "%CURRENT_DIR%msys2-base.sfx.exe" del /F /Q "%CURRENT_DIR%msys2-base.sfx.exe"
if exist "%CURRENT_DIR%VSCodeSetup-x64.exe" del /F /Q "%CURRENT_DIR%VSCodeSetup-x64.exe"

echo.
echo [4/5] Xoa bien moi truong MY_COMPILER va loai bo MSYS2 tu User PATH...
reg delete "HKCU\Environment" /v MY_COMPILER /f >nul 2>&1 || echo [Warn] Bien MY_COMPILER khong ton tai

:: Remove any msys ucrt64 path from User PATH safely via PowerShell
powershell -NoProfile -Command "try { $p = [Environment]::GetEnvironmentVariable('Path','User'); if ($p) { $new = ($p -split ';' | Where-Object { $_ -and $_ -notlike '*msys64*' }) -join ';'; [Environment]::SetEnvironmentVariable('Path',$new,'User') } } catch { exit 1 }"

echo.
echo [5/5] Lam sach cac file cau hinh tam va thong bao hoan tat...
echo.
echo ===================================================
echo   HOAN TAT! May tinh da duoc don dep. Neu van con file MSYS2, hay kiem tra thu cong.
echo ===================================================
pause
exit /b 0

:find_vscode_bin
set "VSCODE_BIN="
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramFiles%\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramFiles(x86)%\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramW6432%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramW6432%\Microsoft VS Code\bin"
goto :eof

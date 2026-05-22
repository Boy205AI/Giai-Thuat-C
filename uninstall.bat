@echo off
title Go bo moi truong C++ (MSYS2 - UCRT64)
echo ===================================================
echo     DANG GO BO MOI TRUONG VA DON DEP HE THONG
echo ===================================================

set "CURRENT_DIR=%~dp0"
set "MSYS_DIR=%CURRENT_DIR%msys64"

echo.
echo [1/4] Dang go bo VS Code Extensions...
call code --uninstall-extension ms-vscode.cpptools >nul 2>&1
call code --uninstall-extension formulahendry.code-runner >nul 2>&1
call code --uninstall-extension zhuangtongfa.Material-theme >nul 2>&1

echo.
echo [2/4] Dang xoa thu muc MSYS2 (msys64)...
if exist "%MSYS_DIR%" (
    echo [..] Dang xoa "%MSYS_DIR%" ...
    rmdir /s /q "%MSYS_DIR%" >nul 2>&1
    if exist "%MSYS_DIR%" (
        echo [Loi] Khong the xoa "%MSYS_DIR%". Vui long dong cac chuong trinh dang su dung thu muc va thu lai.
    ) else (
        echo [OK] Da xoa thu muc msys64.
    )
)

echo.
echo [3/4] Dang xoa cac file installer (neu co)...
if exist "%CURRENT_DIR%msys2-base-latest.sfx.exe" del /f /q "%CURRENT_DIR%msys2-base-latest.sfx.exe"
for %%F in ("%CURRENT_DIR%msys2-base*.sfx.exe" "%CURRENT_DIR%msys2-base*.exe" "%CURRENT_DIR%VSCodeSetup*.exe" "%CURRENT_DIR%vscode_setup.exe") do (
    if exist %%~F del /f /q "%%~F"
)

echo.
echo [4/4] Dang xoa bien moi truong MY_COMPILER va loai bo PATH user entry...
reg delete "HKCU\Environment" /v MY_COMPILER /f >nul 2>&1

powershell -NoProfile -Command "& { $msysPath = '%MSYS_DIR%ucrt64\\bin'; $userPath = [Environment]::GetEnvironmentVariable('Path','User'); if ($userPath -and $userPath -match [regex]::Escape($msysPath)) { $parts = $userPath -split ';' | Where-Object { $_ -and $_ -ne $msysPath }; $new = $parts -join ';'; [Environment]::SetEnvironmentVariable('Path',$new,'User'); Write-Output 'Removed user PATH entry: ' + $msysPath } else { Write-Output 'User PATH entry not found.' } }" >nul 2>&1

echo.
echo ===================================================
echo   HOAN TAT! May tinh cua ban da duoc don dep.
echo ===================================================
echo.
echo - Goi: Chay lai may/thoat va dang nhap lai de PATH user duoc cap nhat.
if "%SKIP_PAUSE%"=="1" (
    exit
) else (
    pause
)
exit

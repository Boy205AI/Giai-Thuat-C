powershell -Command "$c = @'
@echo off
title Bo Cai Dat Tron Goi VS Code + MSYS2 + G++ + GDB
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ CAO CAP (ALL-IN-ONE)
echo ===================================================
cd /d \"%~dp0\"
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo [Loi] Khong tim thay 'curl'. Vui long cap nhat Windows hoac cai dat curl.
    pause
    exit /b 1
)
where code >nul 2>nul
if %errorlevel% neq 0 (
    echo Dang tai VSCode ban moi nhat tu Microsoft...
    curl -L -o \"vscode_setup.exe\" \"https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user\"
    echo Dang cai dat am tham VSCode (Silent Install)...
    start /wait vscode_setup.exe /verysilent /mergetasks=!runcode,addtopath
    del \"vscode_setup.exe\"
    set \"PATH=%LocalAppData%\Programs\Microsoft VS Code\bin;%PATH%\"
    echo [OK] Da cai dat VSCode thanh cong!
) else (
    echo [OK] VS Code da duoc cai dat san tren may tinh nay.
)
set \"MSYS_DIR=%CD%\msys64\"
set \"MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-base-x86_64-20240113.sfx.exe\"
set \"INSTALLER=msys2-base.sfx.exe\"
if exist \"%MSYS_DIR%\ucrt64\bin\gdb.exe\" (
    echo [OK] Trinh bien dich va go loi da ton tai san tren may!
    goto :install_extensions
)
echo.
echo [1/4] Dang tai MSYS2 Base...
curl -L -o \"%INSTALLER%\" \"%MSYS_URL%\"
echo.
echo [2/4] Dang giai nen va khoi tao he thong MSYS2...
\"%INSTALLER%\" -y
del \"%INSTALLER%\"
echo.
echo [3/4] Dang ket noi may chu MSYS2.org de tai G++ va GDB...
set /a retry_count=1
:retry_pacman
echo Dang tai goi va dong bo thong qua Pacman (Lan thu %retry_count%/3)...
call \"%MSYS_DIR%\usr\bin\bash.exe\" -lc \"pacman -Syy --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb\"
if %errorlevel% neq 0 (
    if %retry_count% lss 3 (
        set /a retry_count+=1
        echo [Canh bao] Tai that bai do loi mang. Tu dong doi 5 giay de thu lai...
        timeout /t 5 >nul
        goto :retry_pacman
    ) else (
        echo [Loi] Khong the tai C++ sau 3 lan thu do loi mang. Vui long kiem tra lai Internet!
        pause
        exit /b 1
    )
)
echo [OK] Da tai va cai dat hoan tat G++ va GDB!
:install_extensions
echo.
echo [4/4] Dang cai dat Extensions cho VS Code...
cmd /c code --install-extension ms-vscode.cpptools --force
cmd /c code --install-extension formulahendry.code-runner --force
cmd /c code --install-extension zhuangtongfa.Material-theme --force
echo.
echo [*] Dang cau hinh bien moi truong PATH cho Windows...
setx MY_COMPILER \"%MSYS_DIR%\ucrt64\bin\" >nul
powershell -Command \"$userPath = [Environment]::GetEnvironmentVariable('Path', 'User'); $newPath = '%MSYS_DIR%\ucrt64\bin'; if ($userPath -notmatch [regex]::Escape($newPath)) { $finalPath = $userPath + ';' + $newPath; [Environment]::SetEnvironmentVariable('Path', $finalPath, 'User') }\"
set \"PATH=%MSYS_DIR%\ucrt64\bin;%PATH%\"
echo ===================================================
echo   HOAN TAT! MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit
'@;  [IO.File]::WriteAllText('D:\CPP MSYS\install_clean.bat', $c, [System.Text.Encoding]::ASCII)

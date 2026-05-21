@echo off
title Bo Cai Dat Tu Dong MSYS2 + G++ + GDB cho moi may tinh
echo ===================================================
echo     DANG KHOI TAO MOI TRUONG C++ TUONG THICH CAO
echo ===================================================

cd /d "%~dp0"
setlocal enabledelayedexpansion

set "MSYS_DIR=%CD%\msys64"
set "MSYS_URL=https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe"
set "INSTALLER=%CD%\msys2-base-latest.sfx.exe"
set "VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable"
set "VSCODE_INSTALLER=%CD%\VSCodeSetup-x64.exe"

:: Kiểm tra curl
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo [Loi] Khong tim thay 'curl'. Vui long cap nhat Windows hoac cai dat curl.
    pause
    exit /b 1
)

:: Nếu chưa có VS Code, thử cài qua winget hoặc tìm trong thư mục cài đặt mặc định
set "VSCODE_BIN="
where.exe code >nul 2>nul
if %errorlevel% neq 0 (
    call :find_vscode_bin
    if defined VSCODE_BIN (
        echo [Thong bao] Da tim thay VS Code tai !VSCODE_BIN!. Dang them vao PATH...
        call :add_vscode_path "!VSCODE_BIN!"
        set "PATH=!VSCODE_BIN!;%PATH%"
    ) else (
        echo.
        echo [Thong bao] Khong tim thay 'code'. Dang kiem tra winget de cai VS Code...
        where.exe winget >nul 2>nul
        if %errorlevel% equ 0 (
            echo [Thong bao] Dang cai dat VS Code bang winget...
            winget install --id Microsoft.VisualStudioCode -e --silent --accept-package-agreements --accept-source-agreements
            if %errorlevel% neq 0 (
                echo [Canh bao] Winget khong the cai VS Code. Ban can cai VS Code bang tay.
            )
        ) else (
            echo [Thong bao] winget khong co san. Dang tai VS Code installer...
            curl -L -o "%VSCODE_INSTALLER%" "%VSCODE_URL%"
            if %errorlevel% neq 0 (
                echo [Loi] Tai VS Code that bai. Vui long kiem tra ket noi internet.
                pause
                exit /b 1
            )
            if not exist "%VSCODE_INSTALLER%" (
                echo [Loi] Khong tim thay file VS Code installer.
                pause
                exit /b 1
            )
            echo [Thong bao] Dang chay VS Code installer...
            start /wait "" "%VSCODE_INSTALLER%" /silent /mergetasks=!runcode
            if %errorlevel% neq 0 (
                echo [Canh bao] Co loi khi cai VS Code. Vui long kiem tra.
            )
            del "%VSCODE_INSTALLER%" 2>nul
        )
    )
)

:: Kiem tra lai code
where.exe code >nul 2>nul
if %errorlevel% neq 0 (
    call :find_vscode_bin
    if defined VSCODE_BIN (
        echo [Thong bao] Da tim thay VS Code tai !VSCODE_BIN!. Dang them vao PATH...
        call :add_vscode_path "!VSCODE_BIN!"
        set "PATH=!VSCODE_BIN!;%PATH%"
    ) else (
        echo [Loi] Khong tim thay lenh 'code' sau khi cai VS Code.
        echo Vui long cai VS Code va them vao PATH, sau do chay lai script.
        pause
        exit /b 1
    )
)

if exist "%MSYS_DIR%\ucrt64\bin\gdb.exe" (
    echo [OK] Trinh bien dich va go loi da ton tai tren may nay!
    goto :install_extensions
)

echo.
echo [1/5] Dang tai MSYS2 Base phien ban moi nhat...
curl -L -o "%INSTALLER%" "%MSYS_URL%"
if %errorlevel% neq 0 (
    echo [Loi] Tai MSYS2 that bai. Vui long kiem tra ket noi internet.
    pause
    exit /b 1
)
if not exist "%INSTALLER%" (
    echo [Loi] Khong tim thay file installer MSYS2.
    pause
    exit /b 1
)

echo.
echo [2/5] Dang giai nen va khoi tao he thong MSYS2...
"%INSTALLER%" -y
if %errorlevel% neq 0 (
    echo [Loi] Giai nen MSYS2 that bai.
    pause
    exit /b 1
)
del "%INSTALLER%" 2>nul

if not exist "%MSYS_DIR%\usr\bin\bash.exe" (
    echo [Loi] Khong tim thay bash.exe. Qua trinh cai dat MSYS2 da loi.
    pause
    exit /b 1
)

echo.
echo [3/5] Dang cap nhat he thong MSYS2 (Core Update)...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"
if %errorlevel% neq 0 (
    echo [Loi] Cap nhat MSYS2 da bi loi.
    pause
    exit /b 1
)
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syuu"
if %errorlevel% neq 0 (
    echo [Loi] Cap nhat lan 2 MSYS2 da bi loi.
    pause
    exit /b 1
)

echo.
echo [*] Dang cap nhat danh sach mirror MSYS2 de tang do ben vung...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "cat > /etc/pacman.d/mirrorlist.ucrt64 <<'EOF'
Server = https://repo.msys2.org/ucrt64/$repo/$arch
Server = https://mirror.msys2.org/msys2/ucrt64/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/ucrt64/$repo/$arch
Server = https://mirrors.ustc.edu.cn/msys2/ucrt64/$repo/$arch
EOF"
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "cat > /etc/pacman.d/mirrorlist.mingw64 <<'EOF'
Server = https://repo.msys2.org/mingw64/$repo/$arch
Server = https://mirror.msys2.org/msys2/mingw64/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw64/$repo/$arch
Server = https://mirrors.ustc.edu.cn/msys2/mingw64/$repo/$arch
EOF"
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "cat > /etc/pacman.d/mirrorlist.msys <<'EOF'
Server = https://repo.msys2.org/msys/$repo/$arch
Server = https://mirror.msys2.org/msys2/msys/$repo/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$repo/$arch
Server = https://mirrors.ustc.edu.cn/msys2/msys/$repo/$arch
EOF"
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman --noconfirm -Syy"
if %errorlevel% neq 0 (
    echo [Canh bao] Cap nhat database goi MSYS2 sau khi thay mirror da bi loi.
    echo [Thong bao] Ban co the tiep tuc, nhung neu gap su co, hay chay lai script lan nua.
)

echo.
echo [4/5] Dang tai va cai dat G++ va GDB...
set /a retry_count=1

:retry_pacman
echo Dang tai goi lan thu %retry_count%/3...
call "%MSYS_DIR%\usr\bin\bash.exe" -lc "pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb"
if %errorlevel% neq 0 (
    if %retry_count% lss 3 (
        set /a retry_count+=1
        echo [Canh bao] Tai that bai do su co mang. Dang tu dong doi 5 giay de thu lai...
        timeout /t 5 >nul
        goto :retry_pacman
    ) else (
        echo [Loi] Khong the tai C++ sau 3 lan thu. Vui long kiem tra Internet va thu lai sau!
        pause
        exit /b 1
    )
)
echo [OK] Da tai va cai dat xong G++ va GDB!

:install_extensions
echo.
echo [5/5] Dang cai dat Extensions cho VS Code...
cmd /c code --install-extension ms-vscode.cpptools --force
cmd /c code --install-extension formulahendry.code-runner --force
cmd /c code --install-extension zhuangtongfa.Material-theme --force

echo.
echo [*] Dang cau hinh bien moi truong PATH cho Windows...
setx MY_COMPILER "%MSYS_DIR%\ucrt64\bin" >nul
powershell -NoProfile -Command "$userPath = [Environment]::GetEnvironmentVariable('Path','User'); $newPath = '%MSYS_DIR%\ucrt64\bin'; if (-not $userPath) { [Environment]::SetEnvironmentVariable('Path',$newPath,'User') } elseif ($userPath -notmatch [regex]::Escape($newPath)) { [Environment]::SetEnvironmentVariable('Path',$userPath + ';' + $newPath,'User') }"

set "PATH=%MSYS_DIR%\ucrt64\bin;%PATH%"

echo ===================================================
echo   HOAN TAT! CAI DAT THANH CONG TREN MAY NAY.
echo   MOI THU DA SAN SANG. DANG MO VS CODE...
echo ===================================================
timeout /t 3 >nul
code .
exit /b 0

:find_vscode_bin
set "VSCODE_BIN="
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramFiles%\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramFiles(x86)%\Microsoft VS Code\bin"
if not defined VSCODE_BIN if exist "%ProgramW6432%\Microsoft VS Code\bin\code.cmd" set "VSCODE_BIN=%ProgramW6432%\Microsoft VS Code\bin"
goto :eof

:add_vscode_path
set "newPath=%~1"
if not defined newPath goto :eof
powershell -NoProfile -Command "$userPath = [Environment]::GetEnvironmentVariable('Path','User'); $newPath = '%newPath%'; if (-not $userPath) { [Environment]::SetEnvironmentVariable('Path',$newPath,'User') } elseif ($userPath -notmatch [regex]::Escape($newPath)) { [Environment]::SetEnvironmentVariable('Path',$userPath + ';' + $newPath,'User') }"
goto :eof

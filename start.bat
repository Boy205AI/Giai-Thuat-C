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

:: 4. Kiem tra va cai dat Extension (Co che tu tim duong dan VS Code)
echo.
echo [4/4] Dang kiem tra va cai dat Extensions cho VS Code...

:: Kiem tra xem lenh 'code' co dang hoat dong khong
where code >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [!] Lenh 'code' chua co trong PATH. Dang thu tim trong cac thu muc he thong...
    :: Quet qua cac duong dan cai dat mac dinh cua VS Code tren Windows
    if exist "%LocalAppData%\Programs\Microsoft VS Code\bin\code.cmd" set "PATH=%LocalAppData%\Programs\Microsoft VS Code\bin;%PATH%"
    if exist "C:\Program Files\Microsoft VS Code\bin\code.cmd" set "PATH=C:\Program Files\Microsoft VS Code\bin;%PATH%"
    if exist "C:\Program Files (x86)\Microsoft VS Code\bin\code.cmd" set "PATH=C:\Program Files (x86)\Microsoft VS Code\bin;%PATH%"
)

:: Thu lai lenh code sau khi da tim kiem
where code >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo [+] Da tim thay VS Code! Dang tien hanh cai dat...
    call code --install-extension ms-vscode.cpptools --force
    call code --install-extension formulahendry.code-runner --force
    echo [OK] Da gui lenh cai dat Extension thanh cong.
) else (
    echo [!] CANH BAO: Khong tim thay VS Code tren may nay. 
    echo Ban hay tu mo VS Code va cai Extension 'C/C++' va 'Code Runner' nhe!
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

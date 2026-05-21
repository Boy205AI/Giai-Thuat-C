# Hướng dẫn cài đặt & gỡ cài đặt môi trường C++ (MSYS2 + UCRT64)

Repo này chứa các script để cài đặt và gỡ cài đặt môi trường phát triển C++ trên Windows (MSYS2 UCRT64), cùng một ví dụ `main.cpp`.

Giữ lại các file quan trọng trong repo:
- `install_msys.bat` — script cài MSYS2, G++/GDB, thêm PATH và cài extension VS Code.
- `uninstall.bat` — script gỡ MSYS2, xóa PATH và gỡ extension khi có.
- `main.cpp`, `algorithm.cpp` — mã nguồn mẫu.

Yêu cầu trước khi chạy:
- Windows 10/11 với quyền người dùng (nếu cần, chạy bằng Administrator để sửa PATH hệ thống).
- `curl` có sẵn (hoặc Windows 10 có `curl` mặc định). `winget` là tùy chọn để cài VS Code.

1) Cài đặt

Mở Command Prompt, chuyển tới thư mục chứa repo rồi chạy:

```bat
cd /d D:\CPP
install_msys.bat
```

Script sẽ:
- Tải MSYS2 installer, cài đặt và chạy cập nhật core.
- Cập nhật mirror phía trong MSYS2 để tăng độ ổn định khi tải gói.
- Cài `mingw-w64-ucrt-x86_64-gcc` (g++) và `mingw-w64-ucrt-x86_64-gdb`.
- Cài các extension VS Code (nếu `code` CLI có sẵn).

Lưu ý: quá trình tải và cài đặt có thể mất thời gian (tùy mạng). Nếu gặp lỗi mirror/pacman, chạy lại script sẽ tự retry.

2) Kiểm tra sau cài đặt

Bạn có thể kiểm tra nhanh:

```bat
where.exe code
if exist msys64\ucrt64\bin\g++.exe echo g++ ok
if exist msys64\ucrt64\bin\gdb.exe echo gdb ok
```

3) Gỡ cài đặt

Để dọn sạch, chạy:

```bat
cd /d D:\CPP
uninstall.bat
```

`uninstall.bat` sẽ:
- Dừng tiến trình MSYS2 nếu đang chạy.
- Gỡ các extension đã cài (nếu `code` CLI có sẵn).
- Xóa thư mục `msys64` (nếu có thể).
- Xóa biến User `MY_COMPILER` và loại bỏ đường dẫn `msys64` khỏi `User PATH`.

4) Build & test ví dụ

Sau khi cài xong, bạn có thể biên dịch `main.cpp` bằng `g++` từ MSYS2 UCRT64 như sau (CMD):

```bat
msys64\ucrt64\bin\g++.exe main.cpp -O2 -o main.exe
main.exe
```

5) Ghi chú phát hành

- File nhị phân build (ví dụ `main_test.exe`) đã bị xóa trước khi phát hành.
- Nếu bạn muốn bật `dry-run` hoặc log verbose cho script, tôi có thể thêm các tùy chọn đó.

Nếu cần, tôi sẽ tạo một bản `RELEASE.md` hoặc đóng gói ZIP sẵn sàng phát hành.

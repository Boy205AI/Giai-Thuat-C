**CPP-ENV (MSYS2 + UCRT64) — Thiết lập môi trường C++ cho Windows**

Phiên bản chuyên dụng này cung cấp hai script chính để:
- Cài đặt: `install_msys.bat` — tải và cài MSYS2 (UCRT64 toolchain), cấu hình PATH, và cài một số extension cho VS Code.
- Gỡ cài đặt: `uninstall.bat` — xóa `msys64`, gỡ extensions đã cài, và dọn các biến môi trường.

**Mục tiêu**: cung cấp môi trường C++ nhẹ, nhất quán cho phòng máy hoặc lớp học, dễ cài bằng một cú nhấp.

---

**Nội dung tệp / thư mục chính**
- `install_msys.bat`: Script tự động tải MSYS2, cài toolchain UCRT64 (GCC/GDB), cấu hình `MY_COMPILER` và thêm `ucrt64\bin` vào `Path` (User). Cũng cố gắng cài VS Code nếu chưa có.
- `uninstall.bat`: Script gỡ extensions, xóa `msys64`, xóa giá trị registry `MY_COMPILER` và loại bỏ entry `...\\ucrt64\\bin` khỏi `Path` của user.
- `msys64/`: Thư mục cài đặt MSYS2 (sẽ được tạo khi chạy `install_msys.bat`).
- `main.cpp`, `algorithm.cpp`: ví dụ mã nguồn mẫu để kiểm tra trình biên dịch.
- `install_msys.bat` và `uninstall.bat` nên được chạy với quyền người dùng bình thường (User). Nếu gặp lỗi quyền, hãy chạy bằng tài khoản admin.

---

**Hướng dẫn cài đặt (nhanh)**
1. Giải nén repository vào một thư mục trên máy (ví dụ `C:\cpp-env` hoặc `D:\cpp`).
2. Mở Command Prompt hoặc nhấp đúp vào `install_msys.bat` từ File Explorer.

Nếu muốn chạy không tương tác (để test/tự động hoá), mở PowerShell tại thư mục đã giải nén và chạy:

```powershell
./install_msys.bat
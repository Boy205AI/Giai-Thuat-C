# 🚀 Giai-Thuat-C: Portable C++ Environment (UCRT64)

Môi trường lập trình C++ di động, tự động cấu hình dành riêng cho sinh viên Khoa học Máy tính (KHMT) khi thực hành tại phòng máy. Giải quyết triệt để vấn đề cài đặt rườm rà và thiếu trình biên dịch trên máy tính trường.

## 📌 Tính năng nổi bật
- **1-Click Setup:** Tự động tải, giải nén và cấu hình Compiler chỉ với một file `.bat`.
- **Không cần Admin:** Hoạt động hoàn hảo trên máy tính bị giới hạn quyền cài đặt.
- **Cấu hình chuẩn:** Tích hợp sẵn bộ cấu hình `.vscode` (IntelliSense, Debug F5, Task Build).
- **Tốc độ:** Sử dụng trình biên dịch UCRT64 mới nhất, tối ưu cho Windows 10/11.

## ⚡ Thao tác thực hiện tại phòng máy
Để sử dụng môi trường này trên máy tính trường, bạn chỉ cần thực hiện 3 bước:

1. **Tải về:** Truy cập vào Repo này, chọn **Code** > **Download ZIP**.
2. **Giải nén:** Giải nén thư mục vừa tải vào ổ `D:` hoặc `Desktop`.
3. **Kích hoạt:** Nháy đúp chuột vào file `start.bat`.

> **Lưu ý:** Trong lần đầu tiên chạy, script sẽ mất khoảng 1-2 phút để tải bộ Compiler từ GitHub Releases. Các lần sau, hệ thống sẽ nhận diện và mở VS Code ngay lập tức.

## 🛠 Cấu trúc môi trường
- **Compiler:** MSYS2 UCRT64 (GCC/G++).
- **VS Code Config:**
  - `tasks.json`: Biên dịch code tự động (`Ctrl + Shift + B`).
  - `launch.json`: Hỗ trợ Debug từng dòng code (`F5`).
  - `c_cpp_properties.json`: Gợi ý code và sửa lỗi gạch chân đỏ.
  - `settings.json`: Tối ưu Code Runner và Terminal.

## ⚠️ Lưu ý cho người dùng
- **Settings Sync:** Đừng quên đăng nhập GitHub vào VS Code để đồng bộ toàn bộ Extension và phím tắt cá nhân của bạn.
- **Link Release:** Đảm bảo link tải trong file `start.bat` trỏ đúng vào bản Release chứa file `ucrt64.zip`.

---
*Dự án được phát triển để tối ưu hóa việc học Giải thuật tại ICTU.*
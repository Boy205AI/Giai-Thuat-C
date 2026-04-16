# 🚀 Giai-Thuat-C: Portable C++ Environment (UCRT64)

Môi trường lập trình C++ di động, tự động cấu hình dành riêng cho sinh viên Khoa học Máy tính (KHMT) khi thực hành tại phòng máy. Giải quyết triệt để vấn đề cài đặt rườm rà và thiếu trình biên dịch trên máy tính trường.

## 📌 Tính năng nổi bật
- **1-Click Setup:** Tự động tải, giải nén và cấu hình Compiler chỉ với một file `.bat`.
- **Không cần Admin:** Hoạt động hoàn hảo trên máy tính bị giới hạn quyền cài đặt.
- **Cấu hình chuẩn:** Tích hợp sẵn bộ cấu hình `.vscode` (IntelliSense, Debug F5, Task Build).
- **Tốc độ:** Sử dụng trình biên dịch UCRT64 mới nhất, tối ưu cho Windows.

---

## 📖 Hướng dẫn sử dụng chi tiết (Step-by-Step)

Để sử dụng môi trường này trên máy tính trường, bạn chỉ cần thực hiện theo các bước sau:

### Bước 1: Tải môi trường về máy
1. Nhấn vào nút `<> Code` (màu xanh lá) ở góc trên bên phải màn hình.
2. Chọn **Download ZIP**.
3. Copy file `.zip` vừa tải về ổ `D:` (hoặc Desktop) và **Giải nén** (Extract Here).

### Bước 2: Kích hoạt tự động
1. Mở thư mục vừa giải nén ra.
2. Tìm và nháy đúp chuột vào file **`start.bat`**.
3. Cửa sổ dòng lệnh đen (CMD) sẽ hiện lên. 
   > *Lưu ý: Lần chạy đầu tiên sẽ mất khoảng 1-2 phút để hệ thống tự động tải bộ Compiler. Các lần sau sẽ mở lên ngay lập tức.*
4. Đợi thông báo thành công, VS Code sẽ tự động bật lên với thư mục code này.

### Bước 3: Viết code và Chạy thử (Quan trọng)
Khi VS Code đã mở lên, cấu hình đã được nạp sẵn. Để chạy code giải thuật:
1. Mở file `main.cpp` có sẵn (hoặc tạo file `.cpp` mới).
2. Viết mã nguồn của bạn.
3. Để biên dịch và chạy, bạn có 2 cách:
   - **Cách 1 (Khuyên dùng để Debug):** Nhấn phím **`F5`**. Trình gỡ lỗi sẽ chạy và bạn có thể theo dõi từng dòng code.
   - **Cách 2 (Chạy nhanh):** Bấm tổ hợp phím **`Ctrl + Shift + B`** để biên dịch, sau đó mở Terminal gõ `./main` để chạy.

---

## 🛠 Cấu trúc môi trường bên trong
- **Compiler:** MSYS2 UCRT64 (GCC/G++).
- **VS Code Config:**
  - `tasks.json`: Cấu hình lệnh biên dịch.
  - `launch.json`: Hỗ trợ công cụ gỡ lỗi (Debugger).
  - `c_cpp_properties.json`: Chuẩn hóa IntelliSense (gợi ý code, chống báo lỗi đỏ).
  - `settings.json`: Tối ưu Terminal.

## ⚠️ Lưu ý nhỏ
- Nếu VS Code của bạn đã đăng nhập tài khoản GitHub/Microsoft, tính năng **Settings Sync** sẽ tự động kéo các Extension (như C/C++, Code Runner) và Theme quen thuộc của bạn về máy trường.
- Đừng thay đổi vị trí các file trong thư mục `.vscode` để tránh mất cấu hình.

---
*Dự án được phát triển để tối ưu hóa việc học Giải thuật.*

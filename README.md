# 🚀 Giai-Thuat-C: Tự động hóa môi trường C++ (MSYS2 - UCRT64)

Bộ công cụ "1-Click" giúp thiết lập môi trường lập trình C++ chuẩn trên Windows, tối ưu cho sinh viên thực hành tại phòng máy ICTU.

## 🛠 Tính năng chính
- **Thông minh:** Tự động phát hiện VS Code. Nếu máy chưa có, script tự tải và cài bản mới nhất từ Microsoft.
- **Hiện đại:** Cài đặt MSYS2 và bộ Compiler UCRT64 (GCC 13+) mới nhất qua Pacman.
- **Tiện lợi:** Tự động cài Extension (C/C++ Tools, Code Runner) và cấu hình phím tắt.
- **Sạch sẽ:** Có sẵn script gỡ cài đặt để dọn dẹp máy tính sau khi thực hành xong.

---

## 📖 Hướng dẫn cài đặt

### Bước 1: Tải về
1. Bấm nút **Code** (màu xanh) -> **Download ZIP**.
2. Giải nén thư mục ra **Desktop** hoặc ổ **D:**.

### Bước 2: Chạy Script
Nháy đúp chuột vào file `install_msys.bat` (hoặc tên file bạn đặt).
- **Trường hợp 1 (Máy đã có VS Code):** Script sẽ tự tìm đường dẫn và cài thêm Compiler + Extension.
- **Trường hợp 2 (Máy chưa có VS Code):** Script sẽ tự động tải bộ cài (~90MB), cài đặt thầm lặng vào máy, sau đó mới cài tiếp Compiler.

> *Lưu ý: Hãy để màn hình đen chạy cho đến khi VS Code tự động mở lên là thành công.*

---

## 💻 Hướng dẫn chạy Code (với Code Runner)

Môi trường đã được cấu hình để chạy trực tiếp trên **Command Prompt (CMD)** để tránh lỗi hiển thị.

1. Mở file `.cpp` bất kỳ (ví dụ: `main.cpp`).
2. Sử dụng tổ hợp phím: **`Ctrl + Alt + N`** để chạy code siêu tốc.
3. Kết quả sẽ hiện ngay ở tab **TERMINAL** phía dưới.
4. Nếu muốn gỡ lỗi (Debug), bạn chỉ cần nhấn **`F5`**.

---

## 🧹 Gỡ cài đặt & Dọn dẹp
Sau khi thực hành xong tại phòng máy, bạn nên chạy file `uninstall.bat` để:
- Gỡ bỏ các Extension đã cài.
- Xóa thư mục Compiler (`msys64`) để trả lại dung lượng bộ nhớ.
- Xóa các biến môi trường đã thiết lập.

*Lưu ý: Để giữ lại VS Code cho người sau dùng, script gỡ cài đặt sẽ không xóa phần mềm VS Code.*

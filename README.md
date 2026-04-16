# 🚀 Giai-Thuat-C: Môi trường C++ "1-Click" (MSYS2 - UCRT64)

Bộ công cụ tự động hóa 100% việc thiết lập môi trường lập trình C++ dành cho sinh viên KHMT tại phòng máy. Hệ thống tự động kéo Trình biên dịch mới nhất trực tiếp từ máy chủ MSYS2.

## 🔥 Tính năng tự động hóa
- **Compiler mới nhất:** Tự động cài đặt `GCC (g++)` và `GDB` bản mới nhất qua trình quản lý gói `pacman`.
- **Extensions:** Tự động cài đặt sẵn C/C++ Tools, Code Runner, và Theme Material (One Dark Pro).
- **Môi trường:** Tự cấu hình biến môi trường (`PATH`), vào VS Code là code được ngay.
- **Dọn dẹp:** Tích hợp file gỡ cài đặt sạch sẽ sau khi thực hành.

---

## 📖 Hướng dẫn sử dụng chi tiết

### BƯỚC 1: Tải về
1. Bấm vào nút `<> Code` (màu xanh lá) góc trên cùng -> Chọn **`Download ZIP`**.
2. Copy file `.zip` vừa tải ra **Desktop** hoặc ổ `D:`.
3. Bấm chuột phải chọn **`Extract Here`** (Giải nén tại đây).
   *(Tuyệt đối không chọn Extract to Giai-Thuat-C-main để tránh lỗi đường dẫn).*

### BƯỚC 2: Kích hoạt (Chỉ 1-Click)
1. Mở thư mục vừa giải nén, nháy đúp chuột vào file **`start.bat`**.
   > *Nếu Windows hiện bảng xanh cảnh báo: Bấm `More info` -> `Run anyway`.*
2. Cửa sổ màu đen sẽ hiện lên. **Lưu ý: Lần chạy đầu tiên sẽ mất khoảng 3-5 phút** để kết nối với máy chủ MSYS2 tải bộ compiler. Hãy kiên nhẫn để nguyên màn hình đen.
3. Khi tải xong, cửa sổ tự đóng, VS Code sẽ tự động mở lên!

### BƯỚC 3: Chạy Code
Mở file `main.cpp`. Bạn có 2 cách chạy:
- **Cách 1 (Khuyên dùng - Dò lỗi F5):** Đặt dấu chấm đỏ ở đầu dòng code, nhấn phím **`F5`** để gỡ lỗi từng bước.
- **Cách 2 (Chạy siêu tốc qua Code Runner):** Nhấn **`Ctrl + Alt + N`**.

---

## 🧹 Dọn dẹp máy tính trường
Sau khi kết thúc buổi học, hãy chạy file **`uninstall.bat`**. Nó sẽ tự động gỡ các Extension, xóa thư mục compiler và reset hệ thống về trạng thái ban đầu.

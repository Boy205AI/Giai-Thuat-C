# 🚀 Môi trường C++ "1-Click" (UCRT64)

Bộ công cụ tự động setup môi trường lập trình C++ dành riêng cho sinh viên KHMT thực hành tại phòng máy. Chỉ cần tải về và chạy, mọi thứ từ Compiler (Trình biên dịch) đến cấu hình VS Code (Phím tắt, Debug, Gợi ý code) sẽ được tự động thiết lập trong 1 phút.

---

## 🛑 Yêu cầu chuẩn bị (Chỉ 1 điều kiện duy nhất)
- Máy tính trường **PHẢI** được cài sẵn **Visual Studio Code (VS Code)**. 

---

## 📖 Hướng dẫn sử dụng chi tiết (Step-by-Step)

### Bước 1: Tải về và Giải nén (Cực kỳ quan trọng)
1. Kéo lên đầu trang này, bấm vào nút xanh lá cây **`<> Code`** -> Chọn **`Download ZIP`**.
2. Copy file `.zip` vừa tải ra **màn hình Desktop** hoặc ổ `D:`.
3. Bấm chuột phải vào file `.zip`, chọn **`Extract Here`** (Giải nén tại đây).
   > ⚠️ **CHÚ Ý:** Tuyệt đối không chọn *Extract to Giai-Thuat-C-main* vì nó sẽ tạo ra thư mục lồng nhau, khiến script không tìm thấy đường dẫn.

### Bước 2: Kích hoạt môi trường (Chỉ làm 1 lần mỗi khi mở máy)
1. Mở thư mục bạn vừa giải nén ra, tìm file có tên **`start.bat`** (hoặc `start`).
2. **Nháy đúp chuột** để chạy file này.
   > 🛡️ **Nếu Windows hiện bảng xanh (SmartScreen) cảnh báo:** Đừng lo! Bạn bấm vào chữ **`More info`** -> Chọn **`Run anyway`**.
3. Một cửa sổ màu đen (CMD) sẽ hiện lên. Hãy để nguyên cho nó chạy. 
   - Lần chạy đầu tiên: Sẽ mất khoảng 1-2 phút để tải bộ Compiler UCRT64 (khoảng hơn 100MB) từ server về máy.
   - Khi tải và giải nén xong, cửa sổ đen sẽ tự động đóng và **VS Code sẽ tự động mở lên**.

### Bước 3: Cách viết Code và Chạy thử (Thành quả)
Khi VS Code đã mở lên, bạn sẽ thấy file **`main.cpp`** có sẵn ở cột bên trái.
1. Nhấn vào file `main.cpp` và viết code giải thuật của bạn vào đó.
2. Để chạy code, bạn có 2 cách cực kỳ tiện lợi:
   - **Cách 1 - Chạy và Gỡ lỗi (Khuyên dùng):** Nhấn phím **`F5`**. Máy sẽ tự động biên dịch và chạy. Nếu bạn đặt dấu chấm đỏ (Breakpoint) ở đầu dòng code, nó sẽ dừng lại để bạn dò xem biến thay đổi thế nào.
   - **Cách 2 - Chạy siêu tốc:** Nhấn tổ hợp phím **`Ctrl + Shift + B`** (để build). Sau đó nhìn xuống bảng Terminal (phía dưới), gõ `./main` và nhấn Enter để xem kết quả.

---

## 🛠 Nếu gặp lỗi báo đỏ trong file code?
Đôi khi VS Code chưa kịp nhận diện đường dẫn (IntelliSense chưa load xong).
- **Cách fix:** Tắt hẳn VS Code đi. Sau đó mở lại thư mục này, hoặc nháy đúp lại file `start.bat` một lần nữa. Lỗi gạch chân đỏ dưới `#include <iostream>` sẽ biến mất.

## 🌟 Mẹo nhỏ cho dân IT
Nếu bạn có tài khoản GitHub, hãy bấm vào biểu tượng hình người ở góc trái dưới cùng của VS Code -> Chọn **Turn on Settings Sync** -> Đăng nhập. Toàn bộ theme (giao diện), bộ gõ tiếng Việt, hay các extension quen thuộc từ máy ở nhà của bạn sẽ tự động bay về máy trường!

---
*Dự án được phát triển bởi CauBeIT (ICTU) nhằm hỗ trợ anh em cài đặt g++ dễ dàng hơn.*

# Hướng dẫn khởi chạy dự án (LockerKorea, Sneakers, etc.)

Dự án này bao gồm 4 phần chính:
1. **Hạ tầng (Docker)**: Cơ sở dữ liệu MySQL, phpMyAdmin, và vector database Chroma.
2. **AI / Embedding Service (Python)**: Sub-service hỗ trợ tính năng AI (nhúng vector).
3. **Backend (Spring Boot)**: API Core viết bằng Java 17.
4. **Frontend (Angular)**: Giao diện web.

---

## 🛠 Yêu cầu hệ thống
- **Docker Desktop** (đã cài đặt và đang chạy).
- **Java 17** và biến môi trường `JAVA_HOME` đã trỏ đến Java 17.
- **Node.js** (Khuyến nghị bản LTS 18.x - 20.x).
- **Python 3.10+** (có công cụ `pip` và `venv` để chạy service AI).

---

## 🚀 Các bước khởi chạy dự án

### Bước 1: Khởi động các container Docker (Cơ sở dữ liệu)
Mở terminal/powershell tại tiến trình gốc của dự án (`datn-master`) và chạy script tự động:

```powershell
.\docker-start.ps1
```
*Lưu ý: Script này sẽ kiểm tra xem Docker Desktop đã chạy chưa, tự động tạo các container cần thiết: `mysql8-container`, `phpmyadmin8-container`, `chroma-container`.*
- Database MySQL sẽ tự động nạp file `./Backend/lockerkorea.sql` ở lần chạy đầu tiên. Nếu có lỗi cấu trúc, bạn có thể tự import file bằng cách truy cập `http://localhost:8100` (User: `root` / Pass: `admin`), tạo database `lockerkorea` rồi import vào.

---

### Bước 2: Chạy Python Embedding Service (AI)
Mở một terminal mới, chuyển đến thư mục `python-embedding-service`:

```powershell
cd python-embedding-service
.\start.bat
```
*(Nếu bạn chạy lần đầu hoặc script `start.bat` không gọi tự động, hãy làm thủ công như sau: `python -m venv .venv`, sau đó Active venv, `pip install -r requirements.txt`, rồi `uvicorn app:app --host 0.0.0.0 --port 9001`)*

---

### Bước 3: Chạy Backend (Spring Boot)
Mở một terminal mới, chuyển đến thư mục `Backend`:

```powershell
cd Backend
# Dùng maven wrapper có sẵn để build và chạy dự án (không yêu cầu cài maven môi trường)
.\mvnw clean install -DskipTests
.\mvnw spring-boot:run
```
*Lưu ý: Backend chạy tại cổng `8089`.*

---

### Bước 4: Chạy Frontend (Angular)
Mở một terminal mới, chuyển đến thư mục `Frontend`:

```powershell
cd Frontend
# Cài đặt các gói phụ thuộc (dùng force/legacy-peer-deps để bỏ qua conflict giữa các phiên bản cũ/mới)
npm install --legacy-peer-deps

# Khởi chạy frontend server
npm start
```
*Lưu ý: Giao diện web chạy tại địa chỉ `http://localhost:4200`.*

---

## 🔐 Thông tin đăng nhập mặc định
Sau khi toàn bộ hệ thống đã chạy, truy cập vào giao diện Web (`http://localhost:4200`) và sử dụng tài khoản Admin sau để trải nghiệm:

- **Số điện thoại đăng nhập**: `0999888777`
- **Mật khẩu**: `admin`

# lockkorea_co_Ngoc

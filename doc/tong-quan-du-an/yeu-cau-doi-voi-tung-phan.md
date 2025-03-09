---
description: Yêu cầu chung
---

# Yêu cầu đối với từng phần

## Phần BE:&#x20;

* Khi triển khai chức năng phải theo 3 lớp: Controller nhận request -> Service xử lí logic -> Repository tương tác với CSDL.
* Controller nếu nhận dữ liệu từ FE thì cần phải validate dữ liệu (sử dụng express-validator)
*   Controller cần phần đăng kí router để có thể chạy. Dữ liệu trả về phải dựa trên lớp cở sở&#x20;

    ```typescript
    ResponseData
    ```

## Phần FE:

* Phần giao diện phải được đưa vào src/componentsk mặc định đưa nó vào trong pages.
* Xử lí APIs phải dùng lớp Service ở src/service. Nếu không có phải tự tạo.
* Phần giao diện chỉ xử lí giao diện không được call API, phải dùng lớp Service call qua.
* Nhớ phải triển khai router cho page thì mới chạy nhé.


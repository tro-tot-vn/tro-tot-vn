---
description: Giới thiệu
---

# Backend

```
└── src
    ├── domains
    │   └── entities
    ├── infras
    │   ├── db
    │   └── repositories
    ├── services
    ├── utils
    │   ├── config
    │   └── constants
    └── web
        ├── controller
        ├── middlewares
        ├── routers
        └── validator
```

### Mô Tả Thư Mục <a href="#mo-ta-thu-muc" id="mo-ta-thu-muc"></a>

* **domains**: Thư mục này chứa các thực thể kinh doanh cốt lõi của ứng dụng. Nó đại diện cho các mô hình miền xác định cấu trúc và hành vi của các đối tượng dữ liệu.
  * **entities/** - Chứa các thực thể miền đại diện cho các đối tượng kinh doanh cốt lõi.
* **infras**: Xử lý các vấn đề cấp hạ tầng như kết nối cơ sở dữ liệu và kho lưu trữ.
  * **db/** - Quản lý cấu hình cơ sở dữ liệu, di chuyển và thiết lập.
  * **repositories/** - Thực hiện logic truy cập dữ liệu, tương tác với cơ sở dữ liệu để thực hiện các thao tác CRUD.
* **services**: Chứa  logic nghiệp vụ, xử lý và điều phối dữ liệu giữa các repository và datasource.
* **utils**: Chứa các hàm tiện ích, hằng số và cấu hình được sử dụng trên toàn ứng dụng.
  * **config/** - Lưu trữ các cài đặt cấu hình ứng dụng, chẳng hạn như biến môi trường và cấu hình dịch vụ.
  * **constants/** - Chứa các hằng số toàn cầu được sử dụng trong ứng dụng.
* **web**: Chịu trách nhiệm xử lý các yêu cầu và phản hồi HTTP.
  * **controller/** - Định nghĩa các bộ xử lý tuyến đường xử lý yêu cầu từ khách hàng.
  * **middlewares/** - Chứa các hàm middleware để xử lý yêu cầu (ví dụ: xác thực, ghi nhật ký, xử lý lỗi).
  * **routers/** - Định nghĩa ánh xạ tuyến đường kết nối các điểm cuối với các bộ điều khiển.
  * **validator/** - Xử lý xác thực yêu cầu để đảm bảo dữ liệu đầu vào hợp lệ

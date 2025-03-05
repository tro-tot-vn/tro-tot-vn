---
description: Thông tin cơ bản
---

# FrontEnd

### Cấu trúc thư mục làm việc

<pre><code>
<strong>├── public
</strong>└── src
    ├── assets
    ├── components
    │   ├── elements
    │   ├── layouts
    │   ├── pages
    │   ├── providers
    │   └── ui
    ├── config
    ├── hooks
    ├── lib
    │   └── router
    ├── routes
    ├── services
    ├── socketio
    ├── types
    └── utils
</code></pre>

#### Thư mục chính

* **public**: Chứa các tệp tĩnh như hình ảnh, biểu tượng, và các tệp HTML.
* **src**: Thư mục chính chứa mã nguồn của dự án.

#### Thư mục con trong [src](https://vscode-file/vscode-app/usr/share/code/resources/app/out/vs/code/electron-sandbox/workbench/workbench.html)

* **assets**: Chứa các tài nguyên như hình ảnh, biểu tượng, và các tệp CSS.
* **components**: Chứa các React Component được chia thành các thư mục con:
  * **elements**: Các thành phần nhỏ và tái sử dụng.
  * **layouts**: Các bố cục trang.
  * **pages**: Các trang chính của ứng dụng.
  * **providers**: Cung cấp ngữ cảnh (context providers) cho ứng dụng:
  * **ui**: Các thành phần giao diện người dùng.
* **config**: Chứa các tệp cấu hình của dự án.
* **hooks**: Chứa các hook tùy chỉnh của React.
* **lib**: Chứa các thư viện và mã dùng chung, bao gồm:
  * **router**: Cấu hình và quản lý định tuyến.
* **routes**: Chứa các định tuyến của ứng dụng.
* **services**: Xử lí logic nghiệp vụ và API.
* **socketio**: Chứa các cấu hình và quản lý Socket.IO.
* **types**: Chứa các định nghĩa kiểu.
* **utils**: Chứa các tiện ích và hàm hỗ trợ.

Trong đây phần lớn sẽ viết code trên **src**/**components,** **src/routes, src/services**\

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
    │   │   ├── app-provider
    │   │   ├── auth-provider
    │   │   ├── chat-provider
    │   │   └── message-provider
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

<mark style="background-color:blue;">public</mark>: nơi chứa ảnh để xuất ra bên ngoài

<mark style="background-color:blue;">src/components</mark>: đây là nơi chứa các React Component, các code Component đặt ở đây.

<mark style="background-color:blue;">src/config</mark>: chứa file config cho dự án

<mark style="background-color:blue;">src/hooks</mark>: chứa các hàm wrapper của useContext

<mark style="background-color:blue;">src/lib</mark>: chứa thư viện chung cho dự án.

<mark style="background-color:blue;">src/routers</mark>: nơi định nghĩa các router cho các page.

<mark style="background-color:blue;">src/services</mark>: nơi xử lí logic cho dự án, xử lí call api.

<mark style="background-color:blue;">src/types</mark>: định nghĩa các type chung cho dự án

<mark style="background-color:blue;">src/utils</mark>: nơi chứa các phụ trợ func.

p/s: phần lớn code sẽ triển khai ở <mark style="background-color:blue;">src/components</mark>, <mark style="background-color:blue;">src/services</mark>, <mark style="background-color:blue;">src/components</mark>&#x20;

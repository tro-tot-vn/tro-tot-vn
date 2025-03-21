# Tổng quan

```
├── db
│   ├── features
│   ├── run.sh
│   ├── seed-data
│   ├── structures
│   │   ├── 1.create-db.sql
│   │   └── 2.create-schema.sql
│   └── trigger
├── docker-compose.yaml
└── README.md
```

* &#x20;`db/features` chứa các script về chức năng. Phần này là nơi các bạn viết các chức năng. Yêu cầu đối với phần này thì file trong thư mục sẽ tạo theo cấu trúc `<Task ID> + <Feature Name>.sql`&#x20;
* `db/structures` chính là nơi khởi tạo csdl ban đầu.
* `db/seed-data` tạo dữ liệu mẫu cho csdl
* `db/trigger` khởi tạo trigger ban đầu cho csdl.


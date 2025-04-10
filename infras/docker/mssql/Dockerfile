# docker/mssql/Dockerfile
FROM mcr.microsoft.com/mssql/server:2022-latest

# 1. Chuyển sang user root để cài package
USER root

# 2. Chấp nhận EULA để apt có thể cài mssql-server-fts
ENV ACCEPT_EULA=Y

# 3. Cài các tool cần thiết, thêm repo Microsoft cho SQL Server 2022 trên Ubuntu 22.04, rồi cài FTS
RUN apt-get update \
 && apt-get install -y curl gnupg apt-transport-https software-properties-common \
 \
 # Thêm public key của Microsoft
 && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 \
 # Thêm repo dành cho SQL Server 2022 trên Ubuntu 22.04
 && curl -sSL https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list \
      > /etc/apt/sources.list.d/mssql-server-2022.list \
 \
 # Cập nhật lại package list và cài gói Full‑Text Search
 && apt-get update \
 && apt-get install -y mssql-server-fts \
 \
 # Dọn dẹp cache apt để giảm kích thước image
 && rm -rf /var/lib/apt/lists/*

# 4. Chuyển lại user mssql để SQL Server khởi động đúng quyền
USER mssql

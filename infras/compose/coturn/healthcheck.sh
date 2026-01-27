#!/bin/sh
# Kiểm tra Coturn có đang chạy không
ps aux | grep '[t]urnserver' >/dev/null 2>&1
exit $?
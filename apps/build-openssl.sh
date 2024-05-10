#!/bin/bash

include common.sh

# 下载openssl
test -f openssl-1.1.1g.tar.gz || wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz

# 解压文件
tar -xzf openssl-1.1.1g.tar.gz

# 进入解压后的目录
cd openssl-1.1.1g

# 配置安装路径
./config --prefix=/usr/local/musl --openssldir=/usr/local/musl/ssl

# 编译
make -j$(nproc)

# 安装
make install
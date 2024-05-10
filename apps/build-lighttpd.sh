#!/bin/bash

source common.sh

# 下载lighttpd
test -f lighttpd-1.4.73.tar.gz || wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.73.tar.gz

# 解压文件
tar -xzf lighttpd-1.4.73.tar.gz

# 进入解压后的目录
cd lighttpd-1.4.73

# 配置安装路径
./configure --prefix=/usr/local/musl

# 编译
make -j$(nproc)

# 安装
make install

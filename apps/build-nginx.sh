#!/bin/bash

include common.sh

# 下载nginx
test -f nginx-1.18.0.tar.gz || wget http://nginx.org/download/nginx-1.18.0.tar.gz

# 解压文件
tar -xzf nginx-1.18.0.tar.gz

# 进入解压后的目录
cd nginx-1.18.0

# 配置安装路径
./configure --prefix=/usr/local/musl --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --with-http_stub_status_module --with-threads --with-file-aio --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_secure_link_module --with-http_auth_request_module --with-http_random_index_module --with-http_degradation_module --with-http_slice_module --with-http_geoip_module --with-http_image_filter_module --with-http_xslt_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module --with-stream_ssl_preread_module --with-pcre --with-pcre-jit --with-openssl=/usr/local/musl

# 编译
make -j$(nproc)

# 安装
make install

#!/bin/bash
# 2.2.2  Build the Web Server

# VERSION=lighttpd-1.4.50
VERSION=master

pushd lighttpd || exit
git checkout $VERSION
test -e configure || ./autogen.sh
export CC=musl-gcc CFLAGS='-fPIC -g' LDFLAGS="-pie"
./configure --prefix=/usr/local/musl --without-pcre --without-bzip2 --without-zlib
make -j"$(nproc)" all && make install
popd || exit
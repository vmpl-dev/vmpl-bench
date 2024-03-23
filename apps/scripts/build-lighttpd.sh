#!/bin/bash
# 2.2.2  Build the Web Server

VERSION=lighttpd-1.4.50

pushd lighttpd || exit
git checkout $VERSION
test -e configure || ./autogen.sh
CFLAGS='-fPIC -g' LDFLAGS="-pie" CC=musl-gcc ./configure --without-pcre --without-bzip2 --without-zlib
make -j"$(nproc)"
popd || exit
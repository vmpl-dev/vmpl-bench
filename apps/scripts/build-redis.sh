#!/bin/bash
# 2.2.2  Build the Web Server

VERSION=7.2.4

pushd redis || exit
git checkout $VERSION
CC="musl-gcc"
CFLAGS="-DREDIS_TEST"
LDFLAGS=""
make all -j$(nproc) MALLOC=libc CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
make install PREFIX=/usr/local/musl
popd || exit
#!/bin/bash

# build zlib with musl libc

test -f gzip-1.13.zip || wget https://mirror.fcix.net/gnu/gzip/gzip-1.13.zip
test -d gzip-1.13 || tar -xf gzip-1.13.tar.xz
pushd gzip-1.13
export CC=musl-gcc
./configure --prefix=/usr/local/musl
make -j$(nproc) && make install
popd
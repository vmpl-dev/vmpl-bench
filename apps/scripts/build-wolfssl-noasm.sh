#!/bin/bash

pushd wolfssl
test -f configure || ./autogen.sh
export CC=musl-gcc
./configure --prefix=/usr/local/musl \
            --enable-sp \
            --enable-sp-asm

make -j$(nproc) all && make install
popd
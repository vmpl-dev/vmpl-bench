#!/bin/bash

pushd wolfssl
test -f configure || ./autogen.sh
export CC=musl-gcc
./configure --prefix=/usr/local/musl \
            --enable-dtls \
            --enable-aesni \
            --enable-intelasm \
            --enable-sp \
            --enable-sp-asm \
            --enable-libwebsockets \
            --enable-ntp \
            --enable-rsyslog \
            --enable-all
make -j$(nproc) all && make install
popd
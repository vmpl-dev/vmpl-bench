#!/bin/bash

# 2.2.2  Build the FTP Server
pushd proftpd || exit
export CC=musl-gcc
./configure --prefix=/usr/local/musl
make -j"$(nproc)"
sudo make install
popd || exit
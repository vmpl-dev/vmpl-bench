#!/bin/bash

# Build mbedtls with musl-gcc, and install it to /usr/local/musl
# Enable dymamic linking with musl-gcc
# Enable zlib, benchmarking shows that enabling zlib can improve the performance of mbedtls
VERSION=v1.1.9

pushd unqlite
git checkout $VERSION
pushd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local/musl \
      -DCMAKE_C_COMPILER=musl-gcc \
      ..

make -j$(nproc) && make install
popd
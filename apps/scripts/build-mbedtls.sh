#!/bin/bash

# Build mbedtls with musl-gcc, and install it to /usr/local/musl
# Enable dymamic linking with musl-gcc
# Enable zlib, benchmarking shows that enabling zlib can improve the performance of mbedtls
VERSION=v3.6.0

pushd mbedtls
git checkout $VERSION
git config submodule.framework.url git@github.com:Mbed-TLS/mbedtls-framework.git
git submodule update --init --recursive
pushd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local/musl \
      -DCMAKE_C_COMPILER=musl-gcc \
      -DUSE_SHARED_MBEDTLS_LIBRARY=On \
      -DENABLE_ZLIB_SUPPORT=ON \
      -DENABLE_PROGRAMS=ON \
      -DENABLE_TESTING=ON \
      ..
popd

make -j$(nproc) && make install
popd
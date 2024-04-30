#!/bin/bash

# build sqlite3 with the musl-libc

pushd sqlite3
export CC=musl-gcc
./configure --prefix=$MUSL_HOME
make clean && make -j$(nproc) && make install
popd
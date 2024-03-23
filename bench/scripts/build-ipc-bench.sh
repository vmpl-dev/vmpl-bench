#!/bin/bash

pushd ipc-bench || exit
test -d build || mkdir build
cd build || exit
test -f CMakeCache.txt && rm CMakeCache.txt
cmake .. -DCMAKE_C_COMPILER=musl-gcc
make clean
make -j"$(nproc)"
popd || exit
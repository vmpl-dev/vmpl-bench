#!/bin/bash

nbench_dir=nbench-byte-2.2.3

# This script is used to build nbench on the VMPL benchmarking VM.
pushd $nbench_dir || exit 1
./sysinfo.sh gcc
make clean
make CC=musl-gcc nbench
popd || exit 1

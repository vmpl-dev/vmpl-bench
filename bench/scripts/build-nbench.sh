#!/bin/bash

# This script is used to build nbench on the VMPL benchmarking VM.
pushd nbench || exit 1
make clean
make CC=musl-gcc nbench
popd || exit 1

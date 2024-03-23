#!/bin/bash

# This script builds lmbench from source and runs the benchmark
pushd lmbench || exit
make results CC=musl-gcc -j"$(nproc)"
popd || exit
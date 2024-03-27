#!/bin/bash

source $BENCH_HOME/scripts/common.sh

echo "Running nbench benchmark..."

# Test nbench performance
pushd nbench || exit

./nbench

popd
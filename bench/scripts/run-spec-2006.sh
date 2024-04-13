#!/bin/bash

source $BENCH_HOME/scripts/common.sh

echo "Running CPU2006 benchmark..."

# Test nbench performance
pushd nbench || exit

./nbench

popd
#!/bin/bash

echo "Running bzip2..."

source $BENCH_HOME/scripts/common.sh
if [ $strace_enabled -eq 1 ]; then
    echo "Running bzip2 with strace..."
    strace -o bzip2.strace ./bzip2/bzip2 -f -k -z -v -9 $BENCH_HOME/apps/bzip2/input/input.source
else
    ./bzip2/bzip2 -f -k -z -v -9 $BENCH_HOME/apps/bzip2/input/input.source
fi